import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../pages/detalhamento_page.dart';

part 'item_detalhe_sheet.g.dart';

@riverpod
Future<Map<String, dynamic>?> itemDetalhes(ItemDetalhesRef ref, String itemId) async {
  final client = ref.watch(supabaseProvider);
  try {
    return await client.from('itens')
        .select('*, disciplinas(nome), areas(nome), eap_itens(codigo_wbs, descricao)')
        .eq('id', itemId)
        .maybeSingle();
  } catch (_) { return null; }
}

@riverpod
Future<List<Map<String, dynamic>>> eventosDoItem(EventosDoItemRef ref, String itemId) async {
  final client = ref.watch(supabaseProvider);
  try {
    final data = await client.from('apontamentos')
        .select('id, data_execucao, status, quantidade_realizada, eventos(nome, fases(nome))')
        .eq('item_id', itemId)
        .order('data_execucao', ascending: false);
    return (data as List).cast<Map<String, dynamic>>();
  } catch (_) { return []; }
}

@riverpod
Future<List<Map<String, dynamic>>> vinculosDoItem(VinculosDoItemRef ref, String itemId) async {
  final client = ref.watch(supabaseProvider);
  try {
    final data = await client.from('item_vinculos')
        .select('id, item_vinculado_id, itens!item_vinculos_item_vinculado_id_fkey(tag, componente)')
        .eq('item_id', itemId);
    return (data as List).cast<Map<String, dynamic>>();
  } catch (_) { return []; }
}

class ItemDetalheSheet extends ConsumerStatefulWidget {
  const ItemDetalheSheet({super.key, required this.item});
  final ItemConstrucao item;
  @override
  ConsumerState<ItemDetalheSheet> createState() => _ItemDetalheSheetState();
}

class _ItemDetalheSheetState extends ConsumerState<ItemDetalheSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final detalhes = ref.watch(itemDetalhesProvider(widget.item.id));

    return DraggableScrollableSheet(
      initialChildSize: 0.85, maxChildSize: 0.95, minChildSize: 0.5,
      expand: false,
      builder: (_, ctrl) => Column(children: [
        // Handle
        const SizedBox(height: 12),
        Container(width: 40, height: 4,
            decoration: BoxDecoration(color: IBuildColors.gray300,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 16),

        // Header do item
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _TagBadge(tag: widget.item.tag),
            const SizedBox(height: 6),
            Text(widget.item.componente ?? widget.item.tag,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            if (widget.item.disciplina != null)
              Text(widget.item.disciplina!,
                style: const TextStyle(fontSize: 13, color: IBuildColors.gray500)),
          ])),
          _StatusCircle(status: widget.item.status),
        ])),

        const SizedBox(height: 12),

        // Tabs
        TabBar(
          controller: _tab,
          labelColor: IBuildColors.primary,
          unselectedLabelColor: IBuildColors.gray500,
          indicatorColor: IBuildColors.primary,
          labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Dados'),
            Tab(text: 'Eventos'),
            Tab(text: 'Vínculos'),
          ],
        ),

        Expanded(child: TabBarView(controller: _tab, children: [
          // ── Dados ──────────────────────
          _AbaDetalhes(itemId: widget.item.id, scrollCtrl: ctrl),
          // ── Eventos ────────────────────
          _AbaEventos(itemId: widget.item.id, scrollCtrl: ctrl),
          // ── Vínculos ───────────────────
          _AbaVinculos(itemId: widget.item.id, scrollCtrl: ctrl),
        ])),
      ]),
    );
  }
}

// ── Aba Dados ────────────────────────────────────
class _AbaDetalhes extends ConsumerWidget {
  const _AbaDetalhes({required this.itemId, required this.scrollCtrl});
  final String itemId;
  final ScrollController scrollCtrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dados = ref.watch(itemDetalhesProvider(itemId));
    return dados.when(
      loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
      error: (_, __) => const Center(child: Text('Erro ao carregar')),
      data: (d) => d == null
          ? const Center(child: Text('Item não encontrado'))
          : ListView(controller: scrollCtrl, padding: const EdgeInsets.all(20), children: [
              _GrupoDados('Identificação', [
                _Dado('Tag',        d['tag']),
                _Dado('Componente', d['componente']),
                _Dado('Grupo',      d['grupo']),
                _Dado('Subgrupo',   d['subgrupo']),
                _Dado('Disciplina', d['disciplinas']?['nome']),
                _Dado('Área',       d['areas']?['nome']),
              ]),
              const SizedBox(height: 16),
              _GrupoDados('Especificação técnica', [
                _Dado('Diâmetro',   d['diametro']),
                _Dado('Espessura',  d['espessura']),
                _Dado('Comprimento',d['comprimento']?.toString()),
                _Dado('Peso (kg)',  d['peso']?.toString()),
                _Dado('Área (m²)',  d['area_m2']?.toString()),
                _Dado('Volume',     d['volume']?.toString()),
                _Dado('Quantidade', d['quantidade']?.toString()),
              ]),
              const SizedBox(height: 16),
              _GrupoDados('Controle', [
                _Dado('Revisão atual', d['revisao_atual']),
                _Dado('Status',        d['status']),
                _Dado('EAP',           d['eap_itens']?['codigo_wbs']),
              ]),
              const SizedBox(height: 40),
            ]),
    );
  }
}

class _GrupoDados extends StatelessWidget {
  const _GrupoDados(this.titulo, this.dados);
  final String titulo;
  final List<_Dado> dados;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(titulo.toUpperCase(),
      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
          color: IBuildColors.gray500, letterSpacing: 0.8)),
    const SizedBox(height: 8),
    Container(decoration: BoxDecoration(color: IBuildColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: IBuildColors.gray100)),
      child: Column(children: dados.where((d) => d.valor != null)
          .toList().asMap().entries.map((e) {
        final isLast = e.key == dados.where((d) => d.valor != null).length - 1;
        return Column(children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              Text(e.value.label,
                style: const TextStyle(fontSize: 13, color: IBuildColors.gray500)),
              const Spacer(),
              Text(e.value.valor!,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            ])),
          if (!isLast) const Divider(height: 1, indent: 16, endIndent: 16),
        ]);
      }).toList()),
    ),
  ]);
}

class _Dado {
  final String label; final String? valor;
  const _Dado(this.label, this.valor);
}

// ── Aba Eventos ──────────────────────────────────
class _AbaEventos extends ConsumerWidget {
  const _AbaEventos({required this.itemId, required this.scrollCtrl});
  final String itemId;
  final ScrollController scrollCtrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventos = ref.watch(eventosDoItemProvider(itemId));
    return eventos.when(
      loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
      error: (_, __) => const Center(child: Text('Erro ao carregar eventos')),
      data: (lista) => lista.isEmpty
          ? const Center(child: Text('Nenhum apontamento registrado',
              style: TextStyle(color: IBuildColors.gray500)))
          : ListView.builder(
              controller: scrollCtrl,
              padding: const EdgeInsets.all(16),
              itemCount: lista.length,
              itemBuilder: (_, i) {
                final e = lista[i];
                final data = e['data_execucao'] != null
                    ? DateTime.parse(e['data_execucao']) : null;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    e['status'] == 'aprovado' ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: e['status'] == 'aprovado' ? IBuildColors.success : IBuildColors.warning,
                  ),
                  title: Text(e['eventos']?['nome'] ?? '-',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  subtitle: Text(e['eventos']?['fases']?['nome'] ?? '',
                    style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
                  trailing: data != null
                      ? Text('${data.day.toString().padLeft(2,'0')}/${data.month.toString().padLeft(2,'0')}/${data.year}',
                          style: const TextStyle(fontSize: 11, color: IBuildColors.gray500))
                      : null,
                );
              }),
    );
  }
}

// ── Aba Vínculos ─────────────────────────────────
class _AbaVinculos extends ConsumerWidget {
  const _AbaVinculos({required this.itemId, required this.scrollCtrl});
  final String itemId;
  final ScrollController scrollCtrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vinculos = ref.watch(vinculosDoItemProvider(itemId));
    return vinculos.when(
      loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
      error: (_, __) => const Center(child: Text('Erro ao carregar vínculos')),
      data: (lista) => lista.isEmpty
          ? const Center(child: Text('Nenhum vínculo cadastrado',
              style: TextStyle(color: IBuildColors.gray500)))
          : ListView.builder(
              controller: scrollCtrl,
              padding: const EdgeInsets.all(16),
              itemCount: lista.length,
              itemBuilder: (_, i) {
                final v = lista[i];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.link, color: IBuildColors.gray500),
                  title: Text(v['itens']?['tag'] ?? '-',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 13,
                        fontWeight: FontWeight.w600)),
                  subtitle: Text(v['itens']?['componente'] ?? '',
                    style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
                );
              }),
    );
  }
}

// ── Helpers ──────────────────────────────────────
class _TagBadge extends StatelessWidget {
  const _TagBadge({required this.tag});
  final String tag;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: IBuildColors.primaryLight,
        borderRadius: BorderRadius.circular(6)),
    child: Text(tag, style: const TextStyle(fontSize: 13,
        color: IBuildColors.primary, fontWeight: FontWeight.w700,
        fontFamily: 'monospace')),
  );
}

class _StatusCircle extends StatelessWidget {
  const _StatusCircle({required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    final cor = switch (status) {
      'concluido'    => IBuildColors.success,
      'em_andamento' => IBuildColors.warning,
      'suspenso'     => IBuildColors.error,
      _              => IBuildColors.gray300,
    };
    return Container(width: 16, height: 16,
        decoration: BoxDecoration(shape: BoxShape.circle, color: cor));
  }
}
