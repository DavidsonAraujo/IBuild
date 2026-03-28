import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../core/constants/app_constants.dart';
import '../daos/apontamento_dao.dart';
import '../daos/item_dao.dart';
import '../daos/folha_tarefa_dao.dart';

part 'local_database.g.dart';

// ─────────────────────────────────────────────────────
//  TABELAS LOCAIS (espelho offline do Supabase)
// ─────────────────────────────────────────────────────

// Itens de trabalho (componentes)
class ItensLocal extends Table {
  TextColumn get id            => text()();
  TextColumn get tenantId      => text()();
  TextColumn get subprojetoId  => text()();
  TextColumn get tag           => text()();
  TextColumn get grupo         => text().nullable()();
  TextColumn get subgrupo      => text().nullable()();
  TextColumn get componente    => text().nullable()();
  TextColumn get descricao     => text().nullable()();
  TextColumn get diametro      => text().nullable()();
  TextColumn get status        => text().withDefault(const Constant('pendente'))();
  TextColumn get revisaoAtual  => text().nullable()();
  DateTimeColumn get atualizadoEm => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Eventos de cada item (fases/eventos do template)
class EventosLocal extends Table {
  TextColumn get id            => text()();
  TextColumn get tenantId      => text()();
  TextColumn get faseId        => text()();
  TextColumn get codigo        => text()();
  TextColumn get nome          => text()();
  RealColumn get percentual    => real().nullable()();
  IntColumn  get ordem         => integer().withDefault(const Constant(0))();
  BoolColumn get ativo         => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

// Folhas Tarefa
class FolhasTarefaLocal extends Table {
  TextColumn get id            => text()();
  TextColumn get tenantId      => text()();
  TextColumn get osId          => text()();
  TextColumn get subprojetoId  => text()();
  TextColumn get periodoId     => text()();
  TextColumn get sequencial    => text()();
  TextColumn get status        => text().withDefault(const Constant('aberta'))();
  DateTimeColumn get dataInicio => dateTime().nullable()();
  DateTimeColumn get dataFim    => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Itens da Folha Tarefa
class FolhaTarefaItensLocal extends Table {
  TextColumn get id              => text()();
  TextColumn get tenantId        => text()();
  TextColumn get folhaTarefaId   => text()();
  TextColumn get itemId          => text()();
  TextColumn get eventoId        => text()();
  TextColumn get periodo         => text().nullable()();
  IntColumn  get prioridade      => integer().withDefault(const Constant(0))();
  BoolColumn get executado       => boolean().withDefault(const Constant(false))();
  TextColumn get ticketId        => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Tickets
class TicketsLocal extends Table {
  TextColumn  get id            => text()();
  TextColumn  get tenantId      => text()();
  TextColumn  get folhaTarefaId => text()();
  Int64Column get numero        => int64()();
  TextColumn  get codigo        => text()();
  BoolColumn  get geradoOffline => boolean().withDefault(const Constant(false))();
  DateTimeColumn get geradoEm   => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Apontamentos (incluindo os gerados offline)
class ApontamentosLocal extends Table {
  TextColumn get id                  => text()();
  TextColumn get tenantId            => text()();
  TextColumn get itemId              => text()();
  TextColumn get eventoId            => text()();
  TextColumn get ticketId            => text().nullable()();
  TextColumn get equipeId            => text().nullable()();
  TextColumn get efetivoId           => text().nullable()();
  DateTimeColumn get dataExecucao    => dateTime()();
  RealColumn get qtdPrevista         => real().nullable()();
  RealColumn get qtdRealizada        => real().nullable()();
  TextColumn get status              => text().withDefault(const Constant('rascunho'))();
  // 'rascunho' | 'pendente_sync' | 'sincronizado'
  TextColumn get idOffline           => text().nullable()();
  DateTimeColumn get sincronizadoEm  => dateTime().nullable()();
  DateTimeColumn get criadoEm        => dateTime()();
  TextColumn get usuarioId           => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Fila de sync — operações pendentes para enviar ao Supabase
class FilaSync extends Table {
  IntColumn  get id         => integer().autoIncrement()();
  TextColumn get tabela     => text()();           // 'apontamentos', 'tickets', etc.
  TextColumn get operacao   => text()();           // 'insert' | 'update' | 'delete'
  TextColumn get registroId => text()();
  TextColumn get payload    => text()();           // JSON
  IntColumn  get tentativas => integer().withDefault(const Constant(0))();
  DateTimeColumn get criadoEm => dateTime()();
  DateTimeColumn get proximaTentativa => dateTime()();
  BoolColumn get processado => boolean().withDefault(const Constant(false))();
}

// ─────────────────────────────────────────────────────
//  BANCO DE DADOS PRINCIPAL
// ─────────────────────────────────────────────────────

@DriftDatabase(
  tables: [
    ItensLocal,
    EventosLocal,
    FolhasTarefaLocal,
    FolhaTarefaItensLocal,
    TicketsLocal,
    ApontamentosLocal,
    FilaSync,
  ],
  daos: [
    ApontamentoDao,
    ItemDao,
    FolhaTarefaDao,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // migrações futuras aqui
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: AppConstants.dbLocalNome);
  }
}

// Provider global do banco
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localDatabaseProvider = Provider<LocalDatabase>((ref) {
  final db = LocalDatabase();
  ref.onDispose(db.close);
  return db;
});
