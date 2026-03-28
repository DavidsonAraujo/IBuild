import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../data/models/contexto_usuario.dart';
import '../../../core/theme/app_theme.dart';

part 'suprimentos_page.g.dart';

// ── Models ───────────────────────────────────────
class _RMA {
  final String id, numero, status, osNome;
  final DateTime? dataEmissao;
  final int totalMateriais;
  const _RMA({
    required this.id, required this.numero, required this.status,
    required this.osNome, required this.totalMateriais, this.dataEmissao,
  });
}

class _Material {
  final String id, codigo, descricao;
  final String? unidade;
  final double estoque;
  const _Material({
    required this.id, required this.codigo, required this.descricao,
    this.unidade, this.estoque = 0,
  });
}

class _ItemRMA {
  final String materialId, codigo, descricao;
  final double qtdSolicitada, qtdRetirada;
  final String? unidade;
  const _ItemRMA({
    required this.materialId, required this.codigo, required this.descricao,
    required this.qtdSolicitada, required this.qtdRetirada, this.unidade,
  });
  double get saldo => qtdSolicitada - qtdRetirada;
}

// ── Providers ────────────────────────────────────
@riverpod
Future<List<_RMA>> rmas(RmasRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (!ctx.completo) return [];
  try {
    final data = await client.from('rma')
        .select('id, numero, status, data_emissao, ordens_servico(nome), rma_materiais(id)')
        .eq('tenant_id', ctx.tenantId!)
        .order('data_emissao', ascending: false);
    return (data as List).map((r) => _RMA(
      id: r['id'], numero: r['numero'], status: r['status'],
      osNome: r['ordens_servico']?['nome'] ?? '-',
      totalMateriais: (r['rma_materiais'] as List?)?.length ?? 0,
      dataEmissao: r['data_emissao'] != null ? DateTime.parse(r['data_emissao']) : null,
    )).toList();
  } catch (_) { return []; }
}

@riverpod
Future<List<_ItemRMA>> itensRma(ItensRmaRef ref, String rmaId) async {
  final client = ref.watch(supabaseProvider);
  try {
    final data = await client.from('rma_materiais')
        .select('id, quantidade_solicitada, quantidade_retirada, materiais(id, codigo, descricao, unidade_medida)')
        .eq('rma_id', rmaId);
    return (data as List).map((r) => _ItemRMA(
      materialId: r['materiais']?['id'] ?? '',
      codigo: r['materiais']?['codigo'] ?? '-',
      descricao: r['materiais']?['descricao'] ?? '-',
      unidade: r['materiais']?['unidade_medida'],
      qtdSolicitada: (r['quantidade_solicitada'] ?? 0).toDouble(),
      qtdRetirada: (r['quantidade_retirada'] ?? 0).toDouble(),
    )).toList();
  } catch (_) { return []; }
}

@riverpod
Future<List<_Material>> materiais(MateriaisRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (ctx.tenantId == null) return [];
  try {
    final data = await client.from('materiais')
        .select('id, codigo, descricao, unidade_medida')
        .eq('tenant_id', ctx.tenantId!)
        .order('codigo');
    return (data as List).map((r) => _Material(
      id: r['id'], codigo: r['codigo'], descricao: r['descricao'],
      unidade: r['unidade_medida'],
    )).toList();
  } catch (_) { return []; }
}

// ── Tela principal ───────────────────────────────
class SuprimentosPage extends ConsumerStatefulWidget {
  const SuprimentosPage({super.key});
  @override
  ConsumerState<SuprimentosPage> createState() => _SuprimentosPageState();
}

class _SuprimentosPageState extends ConsumerState<SuprimentosPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  @override
  void initState() { super.initState(); _tab = TabController(length: 2, vsync: this); }
  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final rmaLista = ref.watch(rmasProvider);

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(
        title: const Text('Suprimentos'),
        bottom: TabBar(
          controller: _tab,
          labelColor: IBuildColors.primary,
          indicatorColor: IBuildColors.primary,
          tabs: const [Tab(text: 'RMA'), Tab(text: 'Estoque')],
        ),
      ),
      body: TabBarView(controller: _tab, children: [
        // ── Aba RMA ────────────────────────────
        _AbaRMA(rmas: rmaLista, onNova: () => _novaRMA(context)),
        // ── Aba Estoque ────────────────────────
        const _AbaEstoque(),
      ]),
      floatingActionButton: _tab.index == 0
          ? FloatingActionButton.extended(
              onPressed: () => _novaRMA(context),
              backgroundColor: IBuildColors.primary,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Nova RMA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            )
          : null,
    );
  }

  void _novaRMA(BuildContext ctx) => showModalBottomSheet(
    context: ctx, isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => _NovaRMASheet(onCriada: () => ref.invalidate(rmasProvider)),
  );
}

// ── Aba RMA ──────────────────────────────────────
class _AbaRMA extends StatelessWidget {
  const _AbaRMA({required this.rmas, required this.onNova});
  final AsyncValue<List<_RMA>> rmas;
  final VoidCallback onNova;

  @override
  Widget build(BuildContext context) => rmas.when(
    loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
    error: (_, __) => const Center(child: Text('Erro ao carregar RMAs')),
    data: (lista) => lista.isEmpty
        ? _VazioRMA(onNova: onNova)
        : ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            itemCount: lista.length,
            itemBuilder: (ctx, i) => _RMACard(
              rma: lista[i],
              onTap: () => _abrirRMA(ctx, lista[i]),
            ),
          ),
  );

  void _abrirRMA(BuildContext ctx, _RMA rma) => showModalBottomSheet(
    context: ctx, isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => _DetalheRMASheet(rma: rma),
  );
}

// ── Card de RMA ──────────────────────────────────
class _RMACard extends StatelessWidget {
  const _RMACard({required this.rma, required this.onTap});
  final _RMA rma;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd/MM/yy');
    final (cor, label) = switch (rma.status) {
      'aberta'    => (IBuildColors.info, 'Aberta'),
      'emitida'   => (IBuildColors.warning, 'Emitida'),
      'parcial'   => (IBuildColors.warning, 'Parcial'),
      'encerrada' => (IBuildColors.success, 'Encerrada'),
      _           => (IBuildColors.error, 'Cancelada'),
    };

    return Card(margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap, borderRadius: BorderRadius.circular(12),
        child: Padding(padding: const EdgeInsets.all(14), child: Row(children: [
          Container(width: 44, height: 44,
            decoration: BoxDecoration(
              color: cor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.receipt_long_outlined, color: cor, size: 22)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text('RMA ${rma.numero}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
                    fontFamily: 'monospace')),
              const Spacer(),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: cor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(label,
                  style: TextStyle(fontSize: 11, color: cor, fontWeight: FontWeight.w600))),
            ]),
            const SizedBox(height: 3),
            Text(rma.osNome,
              style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),
            Row(children: [
              Text('${rma.totalMateriais} material(is)',
                style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),
              if (rma.dataEmissao != null) ...[
                const Text(' · ', style: TextStyle(color: IBuildColors.gray300)),
                Text(fmt.format(rma.dataEmissao!),
                  style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),
              ],
            ]),
          ])),
          const Icon(Icons.chevron_right, color: IBuildColors.gray300, size: 18),
        ])),
      ));
  }
}

// ── Detalhe da RMA ────────────────────────────────
class _DetalheRMASheet extends ConsumerWidget {
  const _DetalheRMASheet({required this.rma});
  final _RMA rma;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itens = ref.watch(itensRmaProvider(rma.id));
    return DraggableScrollableSheet(
      initialChildSize: 0.8, maxChildSize: 0.95, minChildSize: 0.5, expand: false,
      builder: (_, ctrl) => Column(children: [
        const SizedBox(height: 12),
        Container(width: 40, height: 4,
            decoration: BoxDecoration(color: IBuildColors.gray300,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 16),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('RMA ${rma.numero}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700,
                  fontFamily: 'monospace')),
            Text(rma.osNome,
              style: const TextStyle(fontSize: 13, color: IBuildColors.gray500)),
          ])),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.print_outlined, size: 16),
            label: const Text('Imprimir', style: TextStyle(fontSize: 12)),
            style: OutlinedButton.styleFrom(minimumSize: const Size(0, 36)),
          ),
        ])),
        const Divider(height: 24),

        // Lista de materiais
        Expanded(child: itens.when(
          loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
          error: (_, __) => const Center(child: Text('Erro ao carregar')),
          data: (lista) => lista.isEmpty
              ? const Center(child: Text('Nenhum material',
                  style: TextStyle(color: IBuildColors.gray500)))
              : ListView.builder(
                  controller: ctrl,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: lista.length,
                  itemBuilder: (_, i) {
                    final item = lista[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: IBuildColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: IBuildColors.gray100),
                      ),
                      child: Row(children: [
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(item.codigo,
                            style: const TextStyle(fontSize: 11, fontFamily: 'monospace',
                                fontWeight: FontWeight.w700, color: IBuildColors.primary)),
                          const SizedBox(height: 2),
                          Text(item.descricao,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        ])),
                        const SizedBox(width: 12),
                        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Text('Sol: ${item.qtdSolicitada.toStringAsFixed(0)} ${item.unidade ?? ''}',
                            style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
                          Text('Ret: ${item.qtdRetirada.toStringAsFixed(0)}',
                            style: const TextStyle(fontSize: 11,
                                color: IBuildColors.success, fontWeight: FontWeight.w600)),
                          if (item.saldo > 0)
                            Text('Saldo: ${item.saldo.toStringAsFixed(0)}',
                              style: const TextStyle(fontSize: 11, color: IBuildColors.warning)),
                        ]),
                      ]),
                    );
                  },
                ),
        )),

        // Botões de ação
        if (rma.status == 'aberta' || rma.status == 'emitida')
          Padding(padding: const EdgeInsets.all(16), child: Row(children: [
            Expanded(child: OutlinedButton(
              onPressed: () {},
              child: const Text('Adicionar material'),
            )),
            const SizedBox(width: 10),
            Expanded(child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check, size: 16),
              label: const Text('Registrar retirada'),
            )),
          ])),
      ]),
    );
  }
}

// ── Sheet nova RMA ────────────────────────────────
class _NovaRMASheet extends ConsumerStatefulWidget {
  const _NovaRMASheet({required this.onCriada});
  final VoidCallback onCriada;
  @override
  ConsumerState<_NovaRMASheet> createState() => _NovaRMASheetState();
}

class _NovaRMASheetState extends ConsumerState<_NovaRMASheet> {
  final _numCtrl = TextEditingController();
  final _materiais = <Map<String, dynamic>>[];
  bool _salvando = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20,
          MediaQuery.viewInsetsOf(context).bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Nova RMA',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        TextField(controller: _numCtrl,
          decoration: const InputDecoration(labelText: 'Número da RMA',
              hintText: 'Ex: RMA-2024-001')),
        const SizedBox(height: 8),
        // Materiais adicionados
        if (_materiais.isNotEmpty) ...[
          const SizedBox(height: 8),
          ...(_materiais.map((m) => ListTile(
            contentPadding: EdgeInsets.zero, dense: true,
            title: Text(m['descricao'] as String,
                style: const TextStyle(fontSize: 13)),
            subtitle: Text('Qtd: ${m['qtd']}',
                style: const TextStyle(fontSize: 11)),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline,
                  color: IBuildColors.error, size: 18),
              onPressed: () => setState(() => _materiais.remove(m)),
            ),
          ))),
        ],
        TextButton.icon(
          onPressed: () => _adicionarMaterial(context),
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Adicionar material'),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _salvando ? null : _salvar,
          child: _salvando
              ? const SizedBox(height: 22, width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Criar RMA'),
        ),
      ]),
    );
  }

  Future<void> _adicionarMaterial(BuildContext ctx) async {
    final mats = await ref.read(materiaisProvider.future);
    if (!ctx.mounted) return;
    final sel = await showDialog<_Material>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Selecionar material'),
        content: SizedBox(height: 300, width: double.maxFinite,
          child: ListView.builder(
            itemCount: mats.length,
            itemBuilder: (_, i) => ListTile(
              dense: true,
              title: Text(mats[i].descricao, style: const TextStyle(fontSize: 13)),
              subtitle: Text('[${mats[i].codigo}]',
                style: const TextStyle(fontSize: 11)),
              onTap: () => Navigator.pop(ctx, mats[i]),
            ),
          )),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
        ],
      ),
    );
    if (sel == null) return;

    // Pedir quantidade
    final qtdCtrl = TextEditingController(text: '1');
    final qtd = await showDialog<double>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text('Quantidade — ${sel.descricao}'),
        content: TextField(controller: qtdCtrl, keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Qtd ${sel.unidade ?? ''}'),
          autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 40)),
            onPressed: () => Navigator.pop(ctx, double.tryParse(qtdCtrl.text)),
            child: const Text('Adicionar')),
        ],
      ),
    );
    if (qtd != null && qtd > 0) {
      setState(() => _materiais.add({
        'material_id': sel.id, 'codigo': sel.codigo,
        'descricao': sel.descricao, 'qtd': qtd,
      }));
    }
  }

  Future<void> _salvar() async {
    if (_numCtrl.text.isEmpty) return;
    setState(() => _salvando = true);
    try {
      final client = ref.read(supabaseProvider);
      final ctx    = ref.read(contextoUsuarioNotifierProvider);
      final rma = await client.from('rma').insert({
        'tenant_id': ctx.tenantId, 'os_id': ctx.osId,
        'numero': _numCtrl.text.trim(), 'status': 'aberta',
        'data_emissao': DateTime.now().toIso8601String().substring(0, 10),
      }).select('id').single();

      if (_materiais.isNotEmpty) {
        await client.from('rma_materiais').insert(
          _materiais.map((m) => {
            'tenant_id': ctx.tenantId, 'rma_id': rma['id'],
            'material_id': m['material_id'],
            'quantidade_solicitada': m['qtd'],
            'quantidade_retirada': 0,
          }).toList(),
        );
      }
      if (mounted) { Navigator.pop(context); widget.onCriada(); }
    } finally { if (mounted) setState(() => _salvando = false); }
  }
}

// ── Aba Estoque ───────────────────────────────────
class _AbaEstoque extends ConsumerWidget {
  const _AbaEstoque();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mats = ref.watch(materiaisProvider);
    return mats.when(
      loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
      error: (_, __) => const Center(child: Text('Erro ao carregar materiais')),
      data: (lista) => lista.isEmpty
          ? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.inventory_2_outlined, size: 64, color: IBuildColors.gray300),
              SizedBox(height: 16),
              Text('Nenhum material cadastrado',
                style: TextStyle(color: IBuildColors.gray500)),
            ]))
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
              itemCount: lista.length,
              itemBuilder: (_, i) {
                final m = lista[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: IBuildColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: IBuildColors.gray100),
                  ),
                  child: Row(children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: IBuildColors.primaryLight,
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(m.codigo, style: const TextStyle(fontSize: 11,
                          color: IBuildColors.primary, fontWeight: FontWeight.w700,
                          fontFamily: 'monospace'))),
                    const SizedBox(width: 10),
                    Expanded(child: Text(m.descricao,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      maxLines: 1, overflow: TextOverflow.ellipsis)),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('${m.estoque.toStringAsFixed(0)} ${m.unidade ?? ''}',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                            color: m.estoque > 0 ? IBuildColors.success : IBuildColors.error)),
                      const Text('em estoque',
                        style: TextStyle(fontSize: 10, color: IBuildColors.gray500)),
                    ]),
                  ]),
                );
              },
            ),
    );
  }
}

class _VazioRMA extends StatelessWidget {
  const _VazioRMA({required this.onNova});
  final VoidCallback onNova;
  @override
  Widget build(BuildContext context) => Center(child: Column(
    mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.receipt_long_outlined, size: 64, color: IBuildColors.gray300),
      const SizedBox(height: 16),
      const Text('Nenhuma RMA encontrada',
        style: TextStyle(color: IBuildColors.gray500)),
      const SizedBox(height: 12),
      ElevatedButton.icon(
        onPressed: onNova,
        icon: const Icon(Icons.add, size: 18),
        label: const Text('Criar primeira RMA'),
        style: ElevatedButton.styleFrom(minimumSize: const Size(0, 44)),
      ),
    ],
  ));
}
