import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../data/models/contexto_usuario.dart';

part 'apontamento_provider.g.dart';

// ─────────────────────────────────────────────────────────────
//  Entidade de item para apontamento (view model)
// ─────────────────────────────────────────────────────────────
class ItemApontamento {
  const ItemApontamento({
    required this.id,
    required this.itemId,
    required this.eventoId,
    required this.tag,
    required this.componente,
    required this.evento,
    required this.fase,
    this.ticketId,
    this.ticketCodigo,
    this.qtdPrevista,
    required this.executado,
    required this.statusSync,
  });

  final String  id;
  final String  itemId;
  final String  eventoId;
  final String  tag;
  final String? componente;
  final String  evento;
  final String  fase;
  final String? ticketId;
  final String? ticketCodigo;
  final double? qtdPrevista;
  final bool    executado;
  final String  statusSync; // 'rascunho' | 'pendente_sync' | 'sincronizado'
}

// ─────────────────────────────────────────────────────────────
//  Estado da lista de apontamentos
// ─────────────────────────────────────────────────────────────
class ApontamentosState {
  const ApontamentosState({
    this.todos = const [],
    this.filtro = '',
  });

  final List<ItemApontamento> todos;
  final String filtro;

  List<ItemApontamento> get pendentes {
    final lista = todos.where((i) => !i.executado).toList();
    if (filtro.isEmpty) return lista;
    return lista.where((i) =>
        i.tag.toLowerCase().contains(filtro.toLowerCase()) ||
        (i.componente?.toLowerCase().contains(filtro.toLowerCase()) ?? false)
    ).toList();
  }

  List<ItemApontamento> get executados {
    final lista = todos.where((i) => i.executado).toList();
    if (filtro.isEmpty) return lista;
    return lista.where((i) =>
        i.tag.toLowerCase().contains(filtro.toLowerCase()) ||
        (i.componente?.toLowerCase().contains(filtro.toLowerCase()) ?? false)
    ).toList();
  }

  int get pendentesSync =>
      todos.where((i) => i.statusSync == 'pendente_sync').length;
}

// ─────────────────────────────────────────────────────────────
//  Provider principal de apontamentos
// ─────────────────────────────────────────────────────────────
@riverpod
class ApontamentosNotifier extends _$ApontamentosNotifier {
  @override
  ApontamentosState build() {
    _carregar();
    return const ApontamentosState();
  }

  Future<void> _carregar() async {
    final client = ref.read(supabaseProvider);
    final ctx = ref.read(contextoUsuarioNotifierProvider);

    if (!ctx.completo) return;

    try {
      // Buscar itens pendentes da FT do subprojeto/período atual
      final data = await client
          .from('folha_tarefa_itens')
          .select('''
            id,
            item_id,
            evento_id,
            executado,
            ticket_id,
            itens!inner(tag, componente),
            eventos!inner(nome, fases!inner(nome))
          ''')
          .eq('tenant_id', ctx.tenantId!)
          .order('executado')
          .limit(200);

      final itens = (data as List).map((row) => ItemApontamento(
        id:          row['id'],
        itemId:      row['item_id'],
        eventoId:    row['evento_id'],
        tag:         row['itens']['tag'],
        componente:  row['itens']['componente'],
        evento:      row['eventos']['nome'],
        fase:        row['eventos']['fases']['nome'],
        ticketId:    row['ticket_id'],
        executado:   row['executado'] ?? false,
        statusSync:  'sincronizado',
      )).toList();

      state = ApontamentosState(todos: itens);
    } catch (e) {
      // Falhou online — carregar do banco local
      await _carregarLocal();
    }
  }

  Future<void> _carregarLocal() async {
    // TODO: implementar consulta ao Drift local
    // final db = ref.read(localDatabaseProvider);
    // final itens = await db.itemDao.listarPendentes();
  }

  void filtrar(String termo) {
    state = ApontamentosState(todos: state.todos, filtro: termo);
  }

  // ── Registrar apontamento (online ou offline) ──
  Future<void> registrar({
    required String itemId,
    required String eventoId,
    required String? ticketId,
    required double? qtdRealizada,
    required DateTime dataExecucao,
    String? observacao,
  }) async {
    final client = ref.read(supabaseProvider);
    final ctx    = ref.read(contextoUsuarioNotifierProvider);
    final uid    = ref.read(supabaseProvider).auth.currentUser?.id;
    final idOffline = const Uuid().v4();

    final payload = {
      'id':            idOffline,
      'tenant_id':     ctx.tenantId,
      'item_id':       itemId,
      'evento_id':     eventoId,
      'ticket_id':     ticketId,
      'data_execucao': dataExecucao.toIso8601String().substring(0, 10),
      'quantidade_realizada': qtdRealizada,
      'status':        'sincronizado',
      'id_offline':    idOffline,
      'usuario_id':    uid,
      'origem':        'app',
    };

    final online = await ref.read(conectadoProvider.future);

    if (online) {
      // Enviar direto ao Supabase
      await client.from('apontamentos').insert(payload);

      // Marcar FT item como executado
      await client
          .from('folha_tarefa_itens')
          .update({'executado': true})
          .eq('item_id', itemId)
          .eq('evento_id', eventoId);
    } else {
      // Salvar local e enfileirar sync
      payload['status'] = 'pendente_sync';
      // TODO: salvar no Drift
      // await ref.read(localDatabaseProvider).apontamentoDao.inserir(payload);
    }

    // Atualizar estado local imediatamente (otimistic update)
    final atualizados = state.todos.map((i) {
      if (i.itemId == itemId && i.eventoId == eventoId) {
        return ItemApontamento(
          id: i.id, itemId: i.itemId, eventoId: i.eventoId,
          tag: i.tag, componente: i.componente,
          evento: i.evento, fase: i.fase,
          ticketId: i.ticketId, ticketCodigo: i.ticketCodigo,
          qtdPrevista: i.qtdPrevista,
          executado: true,
          statusSync: online ? 'sincronizado' : 'pendente_sync',
        );
      }
      return i;
    }).toList();

    state = ApontamentosState(todos: atualizados, filtro: state.filtro);
  }
}

// Alias para o provider
final apontamentosProvider =
    apontamentosNotifierProvider.notifier.select((n) => n);

// ── Verificação de conectividade ─────────────────
@riverpod
Stream<bool> conectado(ConectadoRef ref) {
  return InternetConnection().onStatusChange.map(
    (status) => status == InternetStatus.connected,
  );
}

// ── Provider de Sync ─────────────────────────────
@riverpod
class SyncNotifier extends _$SyncNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> sincronizar() async {
    state = const AsyncValue.loading();
    try {
      // TODO: processar fila de sync do Drift
      // 1. Buscar registros com status = 'pendente_sync'
      // 2. Enviar ao Supabase em ordem de criação
      // 3. Marcar como 'sincronizado'
      // 4. Atualizar estado local
      await Future.delayed(const Duration(seconds: 1)); // placeholder
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final syncProvider = syncNotifierProvider;
