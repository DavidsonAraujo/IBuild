import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';

part 'selecao_componente_page.g.dart';

class _Selecao {
  final String id, nome;
  final int totalItens;
  final DateTime criadoEm;
  const _Selecao({required this.id, required this.nome,
      required this.totalItens, required this.criadoEm});
}

@riverpod
Future<List<_Selecao>> selecoes(SelecoesRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (!ctx.completo) return [];
  try {
    final data = await client.from('selecoes')
        .select('id, nome, criado_em, selecao_itens(id)')
        .eq('tenant_id', ctx.tenantId!)
        .eq('subprojeto_id', ctx.subprojetoId!)
        .order('criado_em', ascending: false);
    return (data as List).map((r) => _Selecao(
      id: r['id'], nome: r['nome'],
      totalItens: (r['selecao_itens'] as List?)?.length ?? 0,
      criadoEm: DateTime.parse(r['criado_em']),
    )).toList();
  } catch (_) { return []; }
}

@riverpod
Future<List<Map<String, dynamic>>> itensSelecao(ItensSelecaoRef ref, String selecaoId) async {
  final client = ref.watch(supabaseProvider);
  try {
    final data = await client.from('selecao_itens')
        .select('id, itens(id, tag, componente, grupo, status)')
        .eq('selecao_id', selecaoId)
        .order('id');
    return (data as List).cast<Map<String, dynamic>>();
  } catch (_) { return []; }
}

class SelecaoComponentePage extends ConsumerWidget {
  const SelecaoComponentePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selecoes = ref.watch(selecoesProvider);

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(title: const Text('Seleção de Componentes')),
      body: selecoes.when(
        loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
        error: (_, __) => const Center(child: Text('Erro ao carregar seleções')),
        data: (lista) => lista.isEmpty
            ? _Vazio(onNova: () => _novaSelecao(context, ref))
            : RefreshIndicator(
                color: IBuildColors.primary,
                onRefresh: () => ref.refresh(selecoesProvider.future),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                  itemCount: lista.length,
                  itemBuilder: (_, i) => _SelecaoCard(
                    selecao: lista[i],
                    onTap: () => _abrirSelecao(context, ref, lista[i]),
                    onExcluir: () => _excluir(context, ref, lista[i]),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _novaSelecao(context, ref),
        backgroundColor: IBuildColors.primary,
        icon: const Icon(Icons.playlist_add, color: IBuildColors.white),
        label: const Text('Nova seleção', style: TextStyle(color: IBuildColors.white,
            fontWeight: FontWeight.w600)),
      ),
    );
  }

  void _abrirSelecao(BuildContext ctx, WidgetRef ref, _Selecao s) =>
      showModalBottomSheet(
        context: ctx, isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => _DetalheSelecaoSheet(selecao: s),
      );

  void _novaSelecao(BuildContext ctx, WidgetRef ref) => showDialog(
    context: ctx,
    builder: (_) => _NovaSelecaoDialog(onCriada: () => ref.invalidate(selecoesProvider)),
  );

  Future<void> _excluir(BuildContext ctx, WidgetRef ref, _Selecao s) async {
    final confirm = await showDialog<bool>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Excluir seleção'),
        content: Text('Excluir "${s.nome}"? Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: IBuildColors.error,
                minimumSize: const Size(80, 40)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      final client = ref.read(supabaseProvider);
      await client.from('selecoes').delete().eq('id', s.id);
      ref.invalidate(selecoesProvider);
    }
  }
}

// ── Card de seleção ──────────────────────────────
class _SelecaoCard extends StatelessWidget {
  const _SelecaoCard({required this.selecao, required this.onTap, required this.onExcluir});
  final _Selecao selecao;
  final VoidCallback onTap, onExcluir;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
        Container(width: 44, height: 44,
          decoration: BoxDecoration(color: IBuildColors.primaryLight,
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.playlist_add_check, color: IBuildColors.primary)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(selecao.nome, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Text('${selecao.totalItens} componente(s)',
            style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),
        ])),
        PopupMenuButton<String>(
          onSelected: (v) { if (v == 'excluir') onExcluir(); },
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'excluir',
              child: Row(children: [
                Icon(Icons.delete_outline, color: IBuildColors.error, size: 18),
                SizedBox(width: 8),
                Text('Excluir', style: TextStyle(color: IBuildColors.error)),
              ])),
          ],
        ),
      ])),
    ),
  );
}

// ── Detalhe de seleção ───────────────────────────
class _DetalheSelecaoSheet extends ConsumerWidget {
  const _DetalheSelecaoSheet({required this.selecao});
  final _Selecao selecao;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itens = ref.watch(itensSelecaoProvider(selecao.id));
    return DraggableScrollableSheet(
      initialChildSize: 0.75, maxChildSize: 0.95, minChildSize: 0.4, expand: false,
      builder: (_, ctrl) => Column(children: [
        const SizedBox(height: 12),
        Container(width: 40, height: 4,
            decoration: BoxDecoration(color: IBuildColors.gray300,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 16),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(selecao.nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text('${selecao.totalItens} componentes',
              style: const TextStyle(fontSize: 13, color: IBuildColors.gray500)),
          ])),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download_outlined, size: 16),
            label: const Text('Exportar', style: TextStyle(fontSize: 13)),
            style: OutlinedButton.styleFrom(minimumSize: const Size(0, 36)),
          ),
        ])),
        const Divider(height: 24),
        Expanded(child: itens.when(
          loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
          error: (_, __) => const Center(child: Text('Erro ao carregar')),
          data: (lista) => ListView.builder(
            controller: ctrl, padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: lista.length,
            itemBuilder: (_, i) {
              final item = lista[i]['itens'];
              if (item == null) return const SizedBox.shrink();
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: IBuildColors.primaryLight,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(item['tag'] ?? '', style: const TextStyle(fontSize: 11,
                      color: IBuildColors.primary, fontWeight: FontWeight.w700,
                      fontFamily: 'monospace'))),
                title: Text(item['componente'] ?? '-',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                subtitle: Text(item['grupo'] ?? '',
                  style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
                trailing: _StatusDot(status: item['status'] ?? 'pendente'),
              );
            },
          ),
        )),
      ]),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    final cor = switch (status) {
      'concluido'    => IBuildColors.success,
      'em_andamento' => IBuildColors.warning,
      _              => IBuildColors.gray300,
    };
    return Container(width: 10, height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: cor));
  }
}

// ── Dialog nova seleção ──────────────────────────
class _NovaSelecaoDialog extends ConsumerStatefulWidget {
  const _NovaSelecaoDialog({required this.onCriada});
  final VoidCallback onCriada;
  @override
  ConsumerState<_NovaSelecaoDialog> createState() => _NovaSelecaoDialogState();
}

class _NovaSelecaoDialogState extends ConsumerState<_NovaSelecaoDialog> {
  final _ctrl = TextEditingController();
  bool _salvando = false;
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Nova Seleção'),
    content: TextField(controller: _ctrl,
        decoration: const InputDecoration(labelText: 'Nome da seleção',
            hintText: 'Ex: Tubulação Área A'),
        autofocus: true),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
      ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(80, 40)),
        onPressed: _salvando ? null : () async {
          if (_ctrl.text.isEmpty) return;
          setState(() => _salvando = true);
          try {
            final client = ref.read(supabaseProvider);
            final ctx    = ref.read(contextoUsuarioNotifierProvider);
            await client.from('selecoes').insert({
              'tenant_id': ctx.tenantId, 'subprojeto_id': ctx.subprojetoId,
              'nome': _ctrl.text.trim(), 'tipo': 'manual',
            });
            if (mounted) { Navigator.pop(context); widget.onCriada(); }
          } finally { if (mounted) setState(() => _salvando = false); }
        },
        child: _salvando
            ? const SizedBox(height: 18, width: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : const Text('Criar'),
      ),
    ],
  );
}

class _Vazio extends StatelessWidget {
  const _Vazio({required this.onNova});
  final VoidCallback onNova;
  @override
  Widget build(BuildContext context) => Center(child: Column(
    mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.playlist_add_check, size: 64, color: IBuildColors.gray300),
      const SizedBox(height: 16),
      const Text('Nenhuma seleção criada',
        style: TextStyle(color: IBuildColors.gray500)),
      const SizedBox(height: 8),
      ElevatedButton.icon(onPressed: onNova,
        icon: const Icon(Icons.add, size: 18),
        label: const Text('Criar primeira seleção'),
        style: ElevatedButton.styleFrom(minimumSize: const Size(0, 44)),
      ),
    ],
  ));
}
