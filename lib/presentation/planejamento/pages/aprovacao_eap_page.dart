import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../data/models/contexto_usuario.dart';
import '../../../core/theme/app_theme.dart';

part 'aprovacao_eap_page.g.dart';

class _AprovacaoItem {
  final String id, eapItemId, codigoWbs, descricao;
  final double avancoSubmetido;
  final String acao, usuarioNome;
  final DateTime criadoEm;
  final String? observacao, evidenciaUrl;
  const _AprovacaoItem({
    required this.id, required this.eapItemId, required this.codigoWbs,
    required this.descricao, required this.avancoSubmetido, required this.acao,
    required this.usuarioNome, required this.criadoEm,
    this.observacao, this.evidenciaUrl,
  });
}

@riverpod
Future<List<_AprovacaoItem>> aprovacoesPendentes(AprovacoesPendentesRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (!ctx.completo) return [];
  try {
    final data = await client.from('eap_historico_aprovacao')
        .select('id, eap_item_id, acao, avanco_submetido, observacao, evidencia_url, criado_em, '
            'eap_itens(codigo_wbs, descricao), perfis(nome)')
        .eq('tenant_id', ctx.tenantId!)
        .eq('acao', 'submetido')
        .order('criado_em', ascending: false);
    return (data as List).map((r) => _AprovacaoItem(
      id: r['id'], eapItemId: r['eap_item_id'],
      codigoWbs: r['eap_itens']?['codigo_wbs'] ?? '',
      descricao: r['eap_itens']?['descricao'] ?? '',
      avancoSubmetido: (r['avanco_submetido'] ?? 0).toDouble(),
      acao: r['acao'],
      usuarioNome: r['perfis']?['nome'] ?? 'Usuário',
      criadoEm: DateTime.parse(r['criado_em']),
      observacao: r['observacao'],
      evidenciaUrl: r['evidencia_url'],
    )).toList();
  } catch (_) { return []; }
}

class AprovacaoEapPage extends ConsumerStatefulWidget {
  const AprovacaoEapPage({super.key});
  @override
  ConsumerState<AprovacaoEapPage> createState() => _AprovacaoEapPageState();
}

class _AprovacaoEapPageState extends ConsumerState<AprovacaoEapPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  @override
  void initState() { super.initState(); _tab = TabController(length: 2, vsync: this); }
  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final pendentes = ref.watch(aprovacoesPendentesProvider);

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(
        title: const Text('Aprovação EAP'),
        bottom: TabBar(
          controller: _tab,
          labelColor: IBuildColors.primary,
          indicatorColor: IBuildColors.primary,
          tabs: [
            Tab(text: 'Pendentes (${pendentes.valueOrNull?.length ?? 0})'),
            const Tab(text: 'Histórico'),
          ],
        ),
      ),
      body: TabBarView(controller: _tab, children: [
        // ── Pendentes ───────────────────────
        pendentes.when(
          loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
          error: (_, __) => const Center(child: Text('Erro ao carregar')),
          data: (lista) => lista.isEmpty
              ? const _Vazio()
              : RefreshIndicator(
                  color: IBuildColors.primary,
                  onRefresh: () => ref.refresh(aprovacoesPendentesProvider.future),
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
                    itemCount: lista.length,
                    itemBuilder: (_, i) => _AprovacaoCard(
                      item: lista[i],
                      onAprovar:  () => _acao(context, ref, lista[i], 'aprovado'),
                      onReprovar: () => _acao(context, ref, lista[i], 'reprovado'),
                    ),
                  ),
                ),
        ),
        // ── Histórico ───────────────────────
        const _HistoricoTab(),
      ]),
    );
  }

  Future<void> _acao(BuildContext ctx, WidgetRef ref, _AprovacaoItem item, String acao) async {
    String? obs;
    if (acao == 'reprovado') {
      obs = await _pedirObservacao(ctx);
      if (obs == null) return; // cancelou
    }

    final client = ref.read(supabaseProvider);
    final uid    = ref.read(supabaseProvider).auth.currentUser?.id;

    // Inserir registro de aprovação/reprovação
    await client.from('eap_historico_aprovacao').insert({
      'tenant_id':         ref.read(contextoUsuarioNotifierProvider).tenantId,
      'eap_item_id':       item.eapItemId,
      'usuario_id':        uid,
      'acao':              acao,
      'avanco_submetido':  item.avancoSubmetido,
      'observacao':        obs,
    });

    // Se aprovado, atualizar avanço real no item
    if (acao == 'aprovado') {
      await client.from('eap_itens')
          .update({'avanco_real': item.avancoSubmetido, 'status': 'em_andamento'})
          .eq('id', item.eapItemId);
    }

    ref.invalidate(aprovacoesPendentesProvider);

    if (ctx.mounted) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(acao == 'aprovado' ? 'Avanço aprovado!' : 'Avanço reprovado.'),
        backgroundColor: acao == 'aprovado' ? IBuildColors.success : IBuildColors.error,
      ));
    }
  }

  Future<String?> _pedirObservacao(BuildContext ctx) {
    final ctrl = TextEditingController();
    return showDialog<String>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Motivo da reprovação'),
        content: TextField(controller: ctrl, maxLines: 3, autofocus: true,
            decoration: const InputDecoration(hintText: 'Descreva o motivo...')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: IBuildColors.error,
                minimumSize: const Size(80, 40)),
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: const Text('Reprovar'),
          ),
        ],
      ),
    );
  }
}

// ── Card de aprovação ─────────────────────────────
class _AprovacaoCard extends StatelessWidget {
  const _AprovacaoCard({required this.item, required this.onAprovar, required this.onReprovar});
  final _AprovacaoItem item;
  final VoidCallback onAprovar, onReprovar;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd/MM/yy HH:mm');
    return Card(margin: const EdgeInsets.only(bottom: 12),
      child: Padding(padding: const EdgeInsets.all(16), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header
        Row(children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: IBuildColors.gray100,
                borderRadius: BorderRadius.circular(4)),
            child: Text(item.codigoWbs, style: const TextStyle(fontSize: 11,
                fontFamily: 'monospace', fontWeight: FontWeight.w700,
                color: IBuildColors.gray700))),
          const Spacer(),
          Text(fmt.format(item.criadoEm),
            style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
        ]),
        const SizedBox(height: 8),

        // Descrição
        Text(item.descricao,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          maxLines: 2, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Text('Submetido por ${item.usuarioNome}',
          style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),

        const SizedBox(height: 12),

        // Avanço submetido
        Container(padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: IBuildColors.primaryLight,
              borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            const Icon(Icons.trending_up, color: IBuildColors.primary, size: 20),
            const SizedBox(width: 8),
            Text('Avanço submetido: ',
              style: const TextStyle(fontSize: 13, color: IBuildColors.gray700)),
            Text('${item.avancoSubmetido.toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                  color: IBuildColors.primary)),
          ])),

        if (item.observacao != null) ...[
          const SizedBox(height: 8),
          Text(item.observacao!,
            style: const TextStyle(fontSize: 12, color: IBuildColors.gray500,
                fontStyle: FontStyle.italic)),
        ],

        const SizedBox(height: 14),

        // Botões
        Row(children: [
          Expanded(child: OutlinedButton.icon(
            onPressed: onReprovar,
            icon: const Icon(Icons.close, size: 16, color: IBuildColors.error),
            label: const Text('Reprovar', style: TextStyle(color: IBuildColors.error)),
            style: OutlinedButton.styleFrom(minimumSize: const Size(0, 44),
                side: const BorderSide(color: IBuildColors.error)),
          )),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton.icon(
            onPressed: onAprovar,
            icon: const Icon(Icons.check, size: 16),
            label: const Text('Aprovar'),
            style: ElevatedButton.styleFrom(minimumSize: const Size(0, 44),
                backgroundColor: IBuildColors.success),
          )),
        ]),
      ])),
    );
  }
}

class _HistoricoTab extends ConsumerWidget {
  const _HistoricoTab();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(supabaseProvider).from('eap_historico_aprovacao')
          .select('id, acao, avanco_submetido, criado_em, eap_itens(codigo_wbs), perfis(nome)')
          .neq('acao', 'submetido')
          .order('criado_em', ascending: false).limit(50),
      builder: (ctx, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: IBuildColors.primary));
        final lista = (snap.data as List).cast<Map<String, dynamic>>();
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: lista.length,
          itemBuilder: (_, i) {
            final r = lista[i];
            final aprovado = r['acao'] == 'aprovado';
            final data = DateTime.parse(r['criado_em']);
            return ListTile(
              leading: Icon(aprovado ? Icons.check_circle : Icons.cancel,
                  color: aprovado ? IBuildColors.success : IBuildColors.error),
              title: Text(r['eap_itens']?['codigo_wbs'] ?? '-',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                    fontFamily: 'monospace')),
              subtitle: Text('${r['perfis']?['nome'] ?? ''} · ${aprovado ? 'Aprovado' : 'Reprovado'}',
                style: const TextStyle(fontSize: 11)),
              trailing: Text('${data.day.toString().padLeft(2,'0')}/${data.month.toString().padLeft(2,'0')}/${data.year}',
                style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
            );
          },
        );
      },
    );
  }
}

class _Vazio extends StatelessWidget {
  const _Vazio();
  @override
  Widget build(BuildContext context) => const Center(child: Column(
    mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.approval_outlined, size: 64, color: IBuildColors.gray300),
      SizedBox(height: 16),
      Text('Nenhum avanço pendente de aprovação',
        style: TextStyle(color: IBuildColors.gray500), textAlign: TextAlign.center),
    ],
  ));
}
