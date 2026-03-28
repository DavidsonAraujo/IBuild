import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../data/models/contexto_usuario.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/item_detalhe_sheet.dart';
import '../widgets/filtros_construcao_sheet.dart';

part 'detalhamento_page.g.dart';

// ── Model ────────────────────────────────────────
class ItemConstrucao {
  final String id, tag, status, subprojetoId;
  final String? grupo, subgrupo, componente, disciplina, diametro, revisao;
  final int totalEventos, eventosExecutados;
  const ItemConstrucao({
    required this.id, required this.tag, required this.status,
    required this.subprojetoId,
    this.grupo, this.subgrupo, this.componente, this.disciplina,
    this.diametro, this.revisao,
    this.totalEventos = 0, this.eventosExecutados = 0,
  });
  double get progresso => totalEventos == 0 ? 0 : eventosExecutados / totalEventos;
}

class _FiltrosConstrucao {
  final String busca, status, grupo;
  const _FiltrosConstrucao({this.busca = '', this.status = 'todos', this.grupo = 'todos'});
  _FiltrosConstrucao copyWith({String? busca, String? status, String? grupo}) =>
      _FiltrosConstrucao(
        busca: busca ?? this.busca, status: status ?? this.status, grupo: grupo ?? this.grupo);
}

// ── Providers ────────────────────────────────────
@riverpod
Future<List<ItemConstrucao>> itensConstrucao(ItensConstrucaoRef ref, _FiltrosConstrucao filtros) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (!ctx.completo) return [];
  try {
    var query = client.from('itens')
        .select('id, tag, status, grupo, subgrupo, componente, diametro, revisao_atual, disciplinas(nome)')
        .eq('tenant_id', ctx.tenantId!)
        .eq('subprojeto_id', ctx.subprojetoId!);

    if (filtros.status != 'todos') query = query.eq('status', filtros.status);
    if (filtros.grupo  != 'todos') query = query.eq('grupo', filtros.grupo);

    final data = await query.order('tag').limit(100);

    var lista = (data as List).map((r) => ItemConstrucao(
      id: r['id'], tag: r['tag'], status: r['status'],
      subprojetoId: ctx.subprojetoId!,
      grupo: r['grupo'], subgrupo: r['subgrupo'], componente: r['componente'],
      disciplina: r['disciplinas']?['nome'], diametro: r['diametro'],
      revisao: r['revisao_atual'],
    )).toList();

    if (filtros.busca.isNotEmpty) {
      final q = filtros.busca.toLowerCase();
      lista = lista.where((i) =>
          i.tag.toLowerCase().contains(q) ||
          (i.componente?.toLowerCase().contains(q) ?? false) ||
          (i.grupo?.toLowerCase().contains(q) ?? false)).toList();
    }
    return lista;
  } catch (_) { return []; }
}

@riverpod
class FiltrosConstrucaoNotifier extends _$FiltrosConstrucaoNotifier {
  @override
  _FiltrosConstrucao build() => const _FiltrosConstrucao();
  void atualizar(_FiltrosConstrucao f) => state = f;
  void buscar(String v)  => state = state.copyWith(busca: v);
  void status(String v)  => state = state.copyWith(status: v);
}

// ── Tela ─────────────────────────────────────────
class DetalhamentoPage extends ConsumerStatefulWidget {
  const DetalhamentoPage({super.key});
  @override
  ConsumerState<DetalhamentoPage> createState() => _DetalhamentoPageState();
}

class _DetalhamentoPageState extends ConsumerState<DetalhamentoPage> {
  final _buscaCtrl = TextEditingController();

  @override
  void dispose() { _buscaCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final filtros = ref.watch(filtrosConstrucaoNotifierProvider);
    final itens   = ref.watch(itensConstrucaoProvider(filtros));

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(
        title: const Text('Detalhamento'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _mostrarFiltros(context),
          ),
          // Chip de filtro ativo
          if (filtros.status != 'todos' || filtros.grupo != 'todos')
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Chip(
                label: const Text('Filtro ativo', style: TextStyle(fontSize: 11)),
                backgroundColor: IBuildColors.primaryLight,
                labelStyle: const TextStyle(color: IBuildColors.primary),
                deleteIconColor: IBuildColors.primary,
                onDeleted: () => ref.read(filtrosConstrucaoNotifierProvider.notifier)
                    .atualizar(const _FiltrosConstrucao()),
              ),
            ),
        ],
      ),
      body: Column(children: [
        // ── Busca ────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _buscaCtrl,
            decoration: InputDecoration(
              hintText: 'Buscar tag, componente, grupo...',
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: filtros.busca.isNotEmpty
                  ? IconButton(icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        _buscaCtrl.clear();
                        ref.read(filtrosConstrucaoNotifierProvider.notifier).buscar('');
                      })
                  : null,
            ),
            onChanged: (v) =>
                ref.read(filtrosConstrucaoNotifierProvider.notifier).buscar(v),
          ),
        ),

        // ── Filtros rápidos de status ─────────
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Row(children: [
            for (final s in [
              ('todos', 'Todos'),
              ('pendente', 'Pendente'),
              ('em_andamento', 'Em andamento'),
              ('concluido', 'Concluído'),
            ])
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(s.$2, style: const TextStyle(fontSize: 12)),
                  selected: filtros.status == s.$1,
                  onSelected: (_) => ref.read(filtrosConstrucaoNotifierProvider.notifier)
                      .status(s.$1),
                  selectedColor: IBuildColors.primaryLight,
                  checkmarkColor: IBuildColors.primary,
                ),
              ),
          ]),
        ),

        // ── Lista ────────────────────────────
        Expanded(child: itens.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: IBuildColors.primary)),
          error: (_, __) => const Center(child: Text('Erro ao carregar itens')),
          data: (lista) => lista.isEmpty
              ? _Vazio(temFiltro: filtros.busca.isNotEmpty || filtros.status != 'todos')
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                  itemCount: lista.length,
                  itemBuilder: (_, i) => _ItemCard(
                    item: lista[i],
                    onTap: () => _abrirDetalhe(context, lista[i]),
                  ),
                ),
        )),
      ]),
    );
  }

  void _abrirDetalhe(BuildContext ctx, ItemConstrucao item) =>
      showModalBottomSheet(
        context: ctx, isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => ItemDetalheSheet(item: item),
      );

  void _mostrarFiltros(BuildContext ctx) =>
      showModalBottomSheet(
        context: ctx, isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => FiltrosConstrucaoSheet(
          filtrosAtuais: ref.read(filtrosConstrucaoNotifierProvider),
          onAplicar: (f) => ref.read(filtrosConstrucaoNotifierProvider.notifier).atualizar(f),
        ),
      );
}

// ── Card do item ─────────────────────────────────
class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item, required this.onTap});
  final ItemConstrucao item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final corStatus = _corStatus(item.status);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Indicador de status
            Container(width: 4, height: 60,
              decoration: BoxDecoration(
                color: corStatus,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Tag + disciplina
              Row(children: [
                _TagBadge(tag: item.tag),
                const SizedBox(width: 8),
                if (item.disciplina != null)
                  _LabelPill(label: item.disciplina!, cor: IBuildColors.info),
                const Spacer(),
                _StatusLabel(status: item.status),
              ]),
              if (item.componente != null) ...[
                const SizedBox(height: 6),
                Text(item.componente!,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
              const SizedBox(height: 6),
              // Grupo / Subgrupo / Diâmetro
              Wrap(spacing: 8, children: [
                if (item.grupo != null) _InfoInline(item.grupo!),
                if (item.subgrupo != null) _InfoInline(item.subgrupo!),
                if (item.diametro != null) _InfoInline('Ø ${item.diametro!}'),
                if (item.revisao != null) _InfoInline('Rev. ${item.revisao!}'),
              ]),
              // Progresso eventos
              if (item.totalEventos > 0) ...[
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: item.progresso, minHeight: 4,
                      backgroundColor: IBuildColors.gray100,
                      valueColor: AlwaysStoppedAnimation(corStatus)),
                  )),
                  const SizedBox(width: 8),
                  Text('${item.eventosExecutados}/${item.totalEventos} eventos',
                    style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
                ]),
              ],
            ])),
            const Icon(Icons.chevron_right, color: IBuildColors.gray300, size: 18),
          ]),
        ),
      ),
    );
  }

  Color _corStatus(String status) => switch (status) {
    'concluido'    => IBuildColors.success,
    'em_andamento' => IBuildColors.warning,
    'suspenso'     => IBuildColors.error,
    'cancelado'    => IBuildColors.gray300,
    _              => IBuildColors.gray300,
  };
}

// ── Widgets auxiliares ────────────────────────────
class _TagBadge extends StatelessWidget {
  const _TagBadge({required this.tag});
  final String tag;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: IBuildColors.primaryLight,
        borderRadius: BorderRadius.circular(6)),
    child: Text(tag, style: const TextStyle(fontSize: 12,
        color: IBuildColors.primary, fontWeight: FontWeight.w700,
        fontFamily: 'monospace')),
  );
}

class _LabelPill extends StatelessWidget {
  const _LabelPill({required this.label, required this.cor});
  final String label; final Color cor;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(color: cor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: cor,
        fontWeight: FontWeight.w500)),
  );
}

class _InfoInline extends StatelessWidget {
  const _InfoInline(this.texto);
  final String texto;
  @override
  Widget build(BuildContext context) => Text(texto,
    style: const TextStyle(fontSize: 11, color: IBuildColors.gray500));
}

class _StatusLabel extends StatelessWidget {
  const _StatusLabel({required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    final (label, cor) = switch (status) {
      'concluido'    => ('Concluído',    IBuildColors.success),
      'em_andamento' => ('Em andamento', IBuildColors.warning),
      'suspenso'     => ('Suspenso',     IBuildColors.error),
      _              => ('Pendente',     IBuildColors.gray300),
    };
    return Text(label, style: TextStyle(fontSize: 11, color: cor,
        fontWeight: FontWeight.w600));
  }
}

class _Vazio extends StatelessWidget {
  const _Vazio({required this.temFiltro});
  final bool temFiltro;
  @override
  Widget build(BuildContext context) => Center(child: Column(
    mainAxisSize: MainAxisSize.min, children: [
      Icon(temFiltro ? Icons.search_off : Icons.view_list_outlined,
          size: 64, color: IBuildColors.gray300),
      const SizedBox(height: 16),
      Text(temFiltro ? 'Nenhum item encontrado' : 'Nenhum item cadastrado',
        style: const TextStyle(color: IBuildColors.gray500)),
    ],
  ));
}
