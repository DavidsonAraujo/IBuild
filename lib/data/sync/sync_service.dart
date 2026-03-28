import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/providers/auth_provider.dart';
import '../local/database/local_database.dart';

part 'sync_service.g.dart';

// ─────────────────────────────────────────────────────────────
//  Motor de Sincronização Offline ↔ Supabase
//
//  Fluxo:
//  1. App detecta que voltou online
//  2. SyncService processa a FilaSync em ordem FIFO
//  3. Cada entrada é enviada ao Supabase
//  4. Em caso de sucesso: marca como processado
//  5. Em caso de erro: incrementa tentativas (até MAX_TENTATIVAS)
//  6. Após MAX_TENTATIVAS: move para fila de erros permanentes
// ─────────────────────────────────────────────────────────────

const _maxTentativas = 3;

class SyncResult {
  final int sucesso, falhou, ignorado;
  final List<String> erros;
  const SyncResult({
    required this.sucesso, required this.falhou,
    required this.ignorado, required this.erros,
  });
  bool get temErros => falhou > 0;
  String get resumo => '$sucesso enviados · $falhou erros · $ignorado ignorados';
}

@riverpod
SyncService syncService(SyncServiceRef ref) {
  return SyncService(
    client: ref.watch(supabaseProvider),
    db:     ref.watch(localDatabaseProvider),
  );
}

class SyncService {
  SyncService({required this.client, required this.db});

  final SupabaseClient client;
  final LocalDatabase  db;

  Timer? _timer;
  bool   _emExecucao = false;

  // ── Iniciar monitoramento automático ─────────
  void iniciar() {
    // Sync a cada 5 minutos se online
    _timer = Timer.periodic(const Duration(minutes: 5), (_) => sincronizar());

    // Sync imediato quando volta online
    InternetConnection().onStatusChange.listen((status) {
      if (status == InternetStatus.connected) sincronizar();
    });
  }

  void parar() => _timer?.cancel();

  // ── Sincronização principal ──────────────────
  Future<SyncResult> sincronizar() async {
    if (_emExecucao) {
      return const SyncResult(sucesso: 0, falhou: 0, ignorado: 0, erros: ['Sync já em andamento']);
    }

    final online = await InternetConnection().hasInternetAccess;
    if (!online) {
      return const SyncResult(sucesso: 0, falhou: 0, ignorado: 1,
          erros: ['Sem conexão com internet']);
    }

    _emExecucao = true;
    int sucesso = 0, falhou = 0, ignorado = 0;
    final erros = <String>[];

    try {
      // Buscar itens pendentes da fila, por ordem de criação
      final fila = await (db.select(db.filaSyncTable)
        ..where((t) => t.processado.equals(false))
        ..where((t) => t.tentativas.isSmallerThanValue(_maxTentativas))
        ..orderBy([(t) => OrderingTerm(expression: t.criadoEm)])
        ..limit(50)
      ).get();

      for (final item in fila) {
        try {
          final payload = jsonDecode(item.payload) as Map<String, dynamic>;

          switch (item.operacao) {
            case 'insert':
              await client.from(item.tabela).upsert(payload,
                  onConflict: 'id_offline'); // deduplicação por id_offline
              break;
            case 'update':
              await client.from(item.tabela)
                  .update(payload)
                  .eq('id', payload['id']);
              break;
            case 'delete':
              await client.from(item.tabela)
                  .delete()
                  .eq('id', payload['id']);
              break;
          }

          // Marcar como processado
          await (db.update(db.filaSyncTable)
            ..where((t) => t.id.equals(item.id))
          ).write(const FilaSyncCompanion(processado: Value(true)));

          sucesso++;

        } catch (e) {
          erros.add('${item.tabela}#${item.registroId}: $e');

          // Incrementar tentativas e agendar próxima
          final proximaTentativa = DateTime.now().add(
            Duration(minutes: _backoffMinutos(item.tentativas + 1)));

          await (db.update(db.filaSyncTable)
            ..where((t) => t.id.equals(item.id))
          ).write(FilaSyncCompanion(
            tentativas:         Value(item.tentativas + 1),
            proximaTentativa:   Value(proximaTentativa),
          ));

          falhou++;
        }
      }

    } finally {
      _emExecucao = false;
    }

    return SyncResult(sucesso: sucesso, falhou: falhou,
        ignorado: ignorado, erros: erros);
  }

  // ── Enfileirar operação para sync posterior ──
  Future<void> enfileirar({
    required String tabela,
    required String operacao,
    required String registroId,
    required Map<String, dynamic> payload,
  }) async {
    await db.into(db.filaSyncTable).insert(FilaSyncCompanion.insert(
      tabela:            tabela,
      operacao:          operacao,
      registroId:        registroId,
      payload:           jsonEncode(payload),
      criadoEm:          DateTime.now(),
      proximaTentativa:  DateTime.now(),
    ));
  }

  // ── Contagem de pendentes ────────────────────
  Future<int> contarPendentes() async {
    final result = await (db.selectOnly(db.filaSyncTable)
      ..addColumns([db.filaSyncTable.id.count()])
      ..where(db.filaSyncTable.processado.equals(false))
    ).getSingle();
    return result.read(db.filaSyncTable.id.count()) ?? 0;
  }

  // ── Backoff exponencial ──────────────────────
  int _backoffMinutos(int tentativa) => switch (tentativa) {
    1 => 1,
    2 => 5,
    3 => 15,
    _ => 30,
  };
}

// ── Provider de estado de sync ───────────────────
@riverpod
class SyncEstado extends _$SyncEstado {
  @override
  AsyncValue<SyncResult?> build() => const AsyncValue.data(null);

  Future<void> sincronizar() async {
    state = const AsyncValue.loading();
    try {
      final resultado = await ref.read(syncServiceProvider).sincronizar();
      state = AsyncValue.data(resultado);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<int> pendentes() =>
      ref.read(syncServiceProvider).contarPendentes();
}

// ── Extensão helper no Drift para FilaSync ───────
extension FilaSyncTableX on $FilaSyncTable {
  // Alias mais legível
  $FilaSyncTable get filaSyncTable => this;
}
