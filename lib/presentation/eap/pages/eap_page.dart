import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';

part 'eap_page.g.dart';

// ── Model de item EAP ────────────────────────────
class _EAPItem {
  final String id, codigoWbs, descricao;
  final int nivel;
  final double avancoReal, avancoPrevisto;
  final String status;
  final List<_EAPItem> filhos;
  const _EAPItem({
    required this.id, required this.codigoWbs, required this.descricao,
    required this.nivel, required this.avancoReal, required this.avancoPrevisto,
    required this.status, this.filhos = const [],
  });
}

@riverpod
Future<List<_EAPItem>> eapRaiz(EapRaizRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (!ctx.completo) return [];
  try {
    final data = await client.from('eap_itens')
        .select()
        .eq('tenant_id', ctx.tenantId!)
        .eq('os_id', ctx.osId!)
        .isFilter('pai_id', null)
        .order('codigo_wbs');
    return (data as List).map((r) => _EAPItem(
      id: r['id'], codigoWbs: r['codigo_wbs'], descricao: r['descricao'],
      nivel: r['nivel'] ?? 1, avancoReal: (r['avanco_real'] ?? 0).toDouble(),
      avancoPrevisto: (r['avanco_previsto'] ?? 0).toDouble(),
      status: r['status'] ?? 'aberto',
    )).toList();
  } catch (_) { return []; }
}

// ── Tela EAP ─────────────────────────────────────
class EapPage extends ConsumerWidget {
  const EapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raiz = ref.watch(eapRaizProvider);

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(
        title: const Text('EAP'),
        actions: [
          IconButton(icon: const Icon(Icons.bar_chart), onPressed: () {}),
          IconButton(icon: const Icon(Icons.download_outlined), onPressed: () {}),
        ],
      ),
      body: raiz.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: IBuildColors.primary)),
        error: (_, __) => const Center(child: Text('Erro ao carregar EAP')),
        data: (itens) => itens.isEmpty
            ? const _Vazio()
            : Column(children: [
                // Resumo de avanço
                _ResumoAvanco(itens: itens),
                // Árvore
                Expanded(child: RefreshIndicator(
                  color: IBuildColors.primary,
                  onRefresh: () => ref.refresh(eapRaizProvider.future),
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                    itemCount: itens.length,
                    itemBuilder: (_, i) => _EAPItemCard(item: itens[i]),
                  ),
                )),
              ]),
      ),
    );
  }
}

// ── Resumo de avanço no topo ─────────────────────
class _ResumoAvanco extends StatelessWidget {
  const _ResumoAvanco({required this.itens});
  final List<_EAPItem> itens;

  @override
  Widget build(BuildContext context) {
    final real = itens.isEmpty ? 0.0
        : itens.map((i) => i.avancoReal).reduce((a, b) => a + b) / itens.length;
    final prev = itens.isEmpty ? 0.0
        : itens.map((i) => i.avancoPrevisto).reduce((a, b) => a + b) / itens.length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IBuildColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: IBuildColors.gray100),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Avanço Geral',
          style: TextStyle(fontSize: 13, color: IBuildColors.gray500,
              fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _BarraAvanco(label: 'Real', valor: real,
              cor: IBuildColors.primary)),
          const SizedBox(width: 16),
          Expanded(child: _BarraAvanco(label: 'Previsto', valor: prev,
              cor: IBuildColors.gray300)),
        ]),
      ]),
    );
  }
}

class _BarraAvanco extends StatelessWidget {
  const _BarraAvanco({required this.label, required this.valor, required this.cor});
  final String label;
  final double valor;
  final Color cor;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [
      Text(label, style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),
      const Spacer(),
      Text('${valor.toStringAsFixed(1)}%',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: cor)),
    ]),
    const SizedBox(height: 6),
    ClipRRect(borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(value: valor / 100, minHeight: 8,
        backgroundColor: IBuildColors.gray100,
        valueColor: AlwaysStoppedAnimation(cor))),
  ]);
}

// ── Card de item EAP com expansão ────────────────
class _EAPItemCard extends ConsumerStatefulWidget {
  const _EAPItemCard({required this.item, this.indentation = 0});
  final _EAPItem item;
  final int indentation;
  @override
  ConsumerState<_EAPItemCard> createState() => _EAPItemCardState();
}

class _EAPItemCardState extends ConsumerState<_EAPItemCard> {
  bool _expandido = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final indent = widget.indentation * 16.0;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Item principal
      InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _abrirAvanço(context, item),
        onLongPress: () => setState(() => _expandido = !_expandido),
        child: Container(
          margin: EdgeInsets.only(left: indent, bottom: 6),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: IBuildColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: IBuildColors.gray100),
            // Destaque por nível
            borderLeft: BorderSide(
              color: _corNivel(item.nivel), width: 3),
          ),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.codigoWbs,
                style: TextStyle(fontSize: 11, color: _corNivel(item.nivel),
                    fontWeight: FontWeight.w600, fontFamily: 'monospace')),
              const SizedBox(height: 2),
              Text(item.descricao,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              // Barra de progresso
              Row(children: [
                Expanded(child: Stack(children: [
                  // Fundo (previsto)
                  ClipRRect(borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: item.avancoPrevisto / 100, minHeight: 5,
                      backgroundColor: IBuildColors.gray100,
                      valueColor: const AlwaysStoppedAnimation(IBuildColors.gray300))),
                  // Real
                  ClipRRect(borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: item.avancoReal / 100, minHeight: 5,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation(
                        item.avancoReal >= item.avancoPrevisto
                            ? IBuildColors.success : IBuildColors.primary))),
                ])),
                const SizedBox(width: 8),
                Text('${item.avancoReal.toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 11,
                      fontWeight: FontWeight.w700)),
              ]),
            ])),
            const SizedBox(width: 8),
            _StatusDot(status: item.status),
          ]),
        ),
      ),
      // Filhos (se expandido)
      if (_expandido && item.filhos.isNotEmpty)
        ...item.filhos.map((f) => _EAPItemCard(
            item: f, indentation: widget.indentation + 1)),
    ]);
  }

  Color _corNivel(int nivel) => switch (nivel) {
    1 => IBuildColors.primary,
    2 => IBuildColors.info,
    3 => IBuildColors.success,
    _ => IBuildColors.gray500,
  };

  void _abrirAvanço(BuildContext ctx, _EAPItem item) => showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => _AvancoSheet(item: item,
        onSalvo: () => ref.invalidate(eapRaizProvider)),
  );
}

// ── Sheet de lançamento de avanço ────────────────
class _AvancoSheet extends ConsumerStatefulWidget {
  const _AvancoSheet({required this.item, required this.onSalvo});
  final _EAPItem item;
  final VoidCallback onSalvo;
  @override
  ConsumerState<_AvancoSheet> createState() => _AvancoSheetState();
}

class _AvancoSheetState extends ConsumerState<_AvancoSheet> {
  late double _avanco;
  bool _salvando = false;

  @override
  void initState() {
    super.initState();
    _avanco = widget.item.avancoReal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20,
          MediaQuery.viewInsetsOf(context).bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(widget.item.codigoWbs,
          style: const TextStyle(fontSize: 12, color: IBuildColors.gray500,
              fontFamily: 'monospace')),
        const SizedBox(height: 4),
        Text(widget.item.descricao,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center),
        const SizedBox(height: 24),
        // Slider de avanço
        Text('Avanço: ${_avanco.toStringAsFixed(0)}%',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700,
              color: IBuildColors.primary)),
        const SizedBox(height: 8),
        Slider(
          value: _avanco,
          min: 0, max: 100, divisions: 20,
          activeColor: IBuildColors.primary,
          onChanged: (v) => setState(() => _avanco = v),
        ),
        // Comparativo
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Previsto: ', style: TextStyle(color: IBuildColors.gray500, fontSize: 12)),
          Text('${widget.item.avancoPrevisto.toStringAsFixed(0)}%',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
        ]),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _salvando ? null : _salvar,
          child: _salvando
              ? const SizedBox(height: 22, width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Salvar avanço'),
        ),
      ]),
    );
  }

  Future<void> _salvar() async {
    setState(() => _salvando = true);
    try {
      final client = ref.read(supabaseProvider);
      await client.from('eap_itens')
          .update({'avanco_real': _avanco})
          .eq('id', widget.item.id);
      if (mounted) { Navigator.pop(context); widget.onSalvo(); }
    } finally { if (mounted) setState(() => _salvando = false); }
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    final cor = switch (status) {
      'concluido'   => IBuildColors.success,
      'em_andamento'=> IBuildColors.warning,
      'suspenso'    => IBuildColors.error,
      _             => IBuildColors.gray300,
    };
    return Container(width: 10, height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: cor));
  }
}

class _Vazio extends StatelessWidget {
  const _Vazio();
  @override
  Widget build(BuildContext context) => const Center(child: Column(
    mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.account_tree_outlined, size: 64, color: IBuildColors.gray300),
      SizedBox(height: 16),
      Text('Nenhum item na EAP', style: TextStyle(color: IBuildColors.gray500)),
    ],
  ));
}
