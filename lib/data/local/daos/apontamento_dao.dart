import 'package:drift/drift.dart';
import '../database/local_database.dart';

// ── DAO de Apontamentos ──────────────────────────
@DriftAccessor(tables: [ApontamentosLocal, FilaSync])
class ApontamentoDao extends DatabaseAccessor<LocalDatabase>
    with _$ApontamentoDaoMixin {
  ApontamentoDao(super.db);

  // Listar apontamentos pendentes de sync
  Future<List<ApontamentosLocalData>> listarPendentesSync() =>
      (select(apontamentosLocal)
        ..where((t) => t.status.equals('pendente_sync'))
        ..orderBy([(t) => OrderingTerm(expression: t.criadoEm)])
      ).get();

  // Inserir apontamento (offline ou online)
  Future<int> inserir(ApontamentosLocalCompanion entry) =>
      into(apontamentosLocal).insert(entry);

  // Marcar como sincronizado
  Future<void> marcarSincronizado(String id) =>
      (update(apontamentosLocal)..where((t) => t.id.equals(id))).write(
        ApontamentosLocalCompanion(
          status:          const Value('sincronizado'),
          sincronizadoEm:  Value(DateTime.now()),
        ),
      );

  // Buscar por id_offline (deduplicação)
  Future<ApontamentosLocalData?> buscarPorIdOffline(String idOffline) =>
      (select(apontamentosLocal)
        ..where((t) => t.idOffline.equals(idOffline))
        ..limit(1)
      ).getSingleOrNull();

  // Contagem de pendentes
  Future<int> contarPendentes(String tenantId) async {
    final count = apontamentosLocal.id.count();
    final result = await (selectOnly(apontamentosLocal)
      ..addColumns([count])
      ..where(apontamentosLocal.tenantId.equals(tenantId))
      ..where(apontamentosLocal.status.equals('pendente_sync'))
    ).getSingle();
    return result.read(count) ?? 0;
  }

  // Listar apontamentos de hoje
  Future<List<ApontamentosLocalData>> listarHoje(String tenantId) {
    final hoje = DateTime.now();
    final inicioHoje = DateTime(hoje.year, hoje.month, hoje.day);
    final fimHoje    = inicioHoje.add(const Duration(days: 1));
    return (select(apontamentosLocal)
      ..where((t) => t.tenantId.equals(tenantId))
      ..where((t) => t.dataExecucao.isBetweenValues(inicioHoje, fimHoje))
      ..orderBy([(t) => OrderingTerm.desc(t.criadoEm)])
    ).get();
  }

  // Stream de pendentes (para exibir badge em tempo real)
  Stream<List<ApontamentosLocalData>> watchPendentes(String tenantId) =>
      (select(apontamentosLocal)
        ..where((t) => t.tenantId.equals(tenantId))
        ..where((t) => t.status.equals('pendente_sync'))
      ).watch();
}

// ── DAO de Itens ─────────────────────────────────
@DriftAccessor(tables: [ItensLocal, EventosLocal])
class ItemDao extends DatabaseAccessor<LocalDatabase>
    with _$ItemDaoMixin {
  ItemDao(super.db);

  // Listar itens de um subprojeto
  Future<List<ItensLocalData>> listarPorSubprojeto(String subprojetoId) =>
      (select(itensLocal)
        ..where((t) => t.subprojetoId.equals(subprojetoId))
        ..orderBy([(t) => OrderingTerm(expression: t.tag)])
      ).get();

  // Buscar por tag
  Future<ItensLocalData?> buscarPorTag(String tag, String subprojetoId) =>
      (select(itensLocal)
        ..where((t) => t.tag.equals(tag))
        ..where((t) => t.subprojetoId.equals(subprojetoId))
        ..limit(1)
      ).getSingleOrNull();

  // Upsert em lote (usado no sync de dados)
  Future<void> upsertLote(List<ItensLocalCompanion> itens) =>
      batch((b) => b.insertAllOnConflictUpdate(itensLocal, itens));

  // Itens com status pendente
  Future<List<ItensLocalData>> listarPendentes(String subprojetoId) =>
      (select(itensLocal)
        ..where((t) => t.subprojetoId.equals(subprojetoId))
        ..where((t) => t.status.equals('pendente'))
      ).get();

  // Stream de todos os itens (watch)
  Stream<List<ItensLocalData>> watchItens(String subprojetoId) =>
      (select(itensLocal)
        ..where((t) => t.subprojetoId.equals(subprojetoId))
        ..orderBy([(t) => OrderingTerm(expression: t.tag)])
      ).watch();
}

// ── DAO de Folha Tarefa ──────────────────────────
@DriftAccessor(tables: [FolhasTarefaLocal, FolhaTarefaItensLocal, TicketsLocal])
class FolhaTarefaDao extends DatabaseAccessor<LocalDatabase>
    with _$FolhaTarefaDaoMixin {
  FolhaTarefaDao(super.db);

  // Listar FTs abertas
  Future<List<FolhasTarefaLocalData>> listarAbertas(String osId) =>
      (select(folhasTarefaLocal)
        ..where((t) => t.osId.equals(osId))
        ..where((t) => t.status.equals('aberta'))
        ..orderBy([(t) => OrderingTerm.desc(t.dataInicio)])
      ).get();

  // Itens de uma FT
  Future<List<FolhaTarefaItensLocalData>> itensDaFT(String ftId) =>
      (select(folhaTarefaItensLocal)
        ..where((t) => t.folhaTarefaId.equals(ftId))
        ..orderBy([(t) => OrderingTerm(expression: t.prioridade)])
      ).get();

  // Ticket por código
  Future<TicketsLocalData?> buscarTicketPorCodigo(String codigo) =>
      (select(ticketsLocal)
        ..where((t) => t.codigo.equals(codigo))
        ..limit(1)
      ).getSingleOrNull();

  // Inserir ticket gerado offline
  Future<int> inserirTicket(TicketsLocalCompanion ticket) =>
      into(ticketsLocal).insert(ticket);

  // Marcar item como executado
  Future<void> marcarExecutado(String itemId) =>
      (update(folhaTarefaItensLocal)
        ..where((t) => t.id.equals(itemId))
      ).write(const FolhaTarefaItensLocalCompanion(
          executado: Value(true)));

  // Upsert de FTs (sync)
  Future<void> upsertFTs(List<FolhasTarefaLocalCompanion> fts) =>
      batch((b) => b.insertAllOnConflictUpdate(folhasTarefaLocal, fts));
}
