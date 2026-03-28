import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../data/models/contexto_usuario.dart';
import '../../../core/theme/app_theme.dart';

part 'folha_tarefa_page.g.dart';

// ── Models ───────────────────────────────────────
class _FT {
  final String id, sequencial, status, faseNome;
  final DateTime? dataInicio, dataFim;
  final int totalItens, executados;
  const _FT({
    required this.id, required this.sequencial, required this.status,
    required this.faseNome, required this.totalItens, required this.executados,
    this.dataInicio, this.dataFim,
  });
  double get progresso => totalItens == 0 ? 0 : executados / totalItens;
}

@riverpod
Future<List<_FT>> folhasTarefa(FolhasTarefaRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (!ctx.completo) return [];
  try {
    final data = await client.from('folhas_tarefa')
        .select('id, sequencial, status, data_inicio, data_fim, fases(nome), folha_tarefa_itens(id, executado)')
        .eq('tenant_id', ctx.tenantId!)
        .eq('subprojeto_id', ctx.subprojetoId!)
        .order('sequencial', ascending: false)
        .limit(50);
    return (data as List).map((r) {
      final itens = (r['folha_tarefa_itens'] as List?) ?? [];
      return _FT(
        id: r['id'], sequencial: r['sequencial'], status: r['status'],
        faseNome: r['fases']?['nome'] ?? '-',
        dataInicio: r['data_inicio'] != null ? DateTime.parse(r['data_inicio']) : null,
        dataFim:    r['data_fim']    != null ? DateTime.parse(r['data_fim'])    : null,
        totalItens: itens.length,
        executados: itens.where((i) => i['executado'] == true).length,
      );
    }).toList();
  } catch (_) { return []; }
}

// ── Tela principal ───────────────────────────────
class FolhaTarefaPage extends ConsumerWidget {
  const FolhaTarefaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lista = ref.watch(folhasTarefaProvider);

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(
        title: const Text('Folha Tarefa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _mostrarFiltros(context),
          ),
        ],
      ),
      body: lista.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: IBuildColors.primary)),
        error: (e, _) => _Erro(erro: e.toString(),
            onRetry: () => ref.invalidate(folhasTarefaProvider)),
        data: (fts) => fts.isEmpty
            ? const _Vazio()
            : RefreshIndicator(
                color: IBuildColors.primary,
                onRefresh: () => ref.refresh(folhasTarefaProvider.future),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                  itemCount: fts.length,
                  itemBuilder: (_, i) => _FTCard(ft: fts[i]),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _novaFT(context, ref),
        backgroundColor: IBuildColors.primary,
        icon: const Icon(Icons.add, color: IBuildColors.white),
        label: const Text('Nova FT', style: TextStyle(color: IBuildColors.white,
            fontWeight: FontWeight.w600)),
      ),
    );
  }

  void _mostrarFiltros(BuildContext ctx) => showModalBottomSheet(
    context: ctx,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => const _FiltrosSheet(),
  );

  void _novaFT(BuildContext ctx, WidgetRef ref) => showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => _NovaFTSheet(onCriada: () => ref.invalidate(folhasTarefaProvider)),
  );
}

// ── Card de FT ───────────────────────────────────
class _FTCard extends StatelessWidget {
  const _FTCard({required this.ft});
  final _FT ft;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd/MM/yy');
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _abrirDetalhe(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Header
            Row(children: [
              _StatusChip(status: ft.status),
              const Spacer(),
              Text(ft.sequencial,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                    color: IBuildColors.gray700, fontFamily: 'monospace')),
            ]),
            const SizedBox(height: 10),

            // Fase
            Text(ft.faseNome,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),

            // Datas
            if (ft.dataInicio != null)
              Text('${fmt.format(ft.dataInicio!)} → ${ft.dataFim != null ? fmt.format(ft.dataFim!) : "em aberto"}',
                style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),

            const SizedBox(height: 12),

            // Progresso
            Row(children: [
              Expanded(child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: ft.progresso,
                  minHeight: 6,
                  backgroundColor: IBuildColors.gray100,
                  valueColor: AlwaysStoppedAnimation(
                    ft.progresso == 1 ? IBuildColors.success : IBuildColors.primary),
                ),
              )),
              const SizedBox(width: 10),
              Text('${ft.executados}/${ft.totalItens}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                    color: IBuildColors.gray700)),
            ]),
          ]),
        ),
      ),
    );
  }

  void _abrirDetalhe(BuildContext ctx) => showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => _DetalhesFTSheet(ft: ft),
  );
}

// ── Detalhe da FT ───────────────────────────────
class _DetalhesFTSheet extends ConsumerWidget {
  const _DetalhesFTSheet({required this.ft});
  final _FT ft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (_, ctrl) => Column(children: [
        const SizedBox(height: 12),
        Container(width: 40, height: 4,
            decoration: BoxDecoration(color: IBuildColors.gray300,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 16),
        // Header
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('FT ${ft.sequencial}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text(ft.faseNome,
              style: const TextStyle(fontSize: 14, color: IBuildColors.gray500)),
          ])),
          _StatusChip(status: ft.status),
        ])),
        const Divider(height: 24),
        // Lista de itens
        Expanded(child: _ItensFTList(ftId: ft.id, scrollCtrl: ctrl)),
        // Botão emitir PDF
        Padding(padding: const EdgeInsets.all(16), child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.picture_as_pdf_outlined),
          label: const Text('Emitir Folha Tarefa (PDF)'),
        )),
      ]),
    );
  }
}

@riverpod
Future<List<Map<String, dynamic>>> itensFT(ItensFTRef ref, String ftId) async {
  final client = ref.watch(supabaseProvider);
  try {
    final data = await client.from('folha_tarefa_itens')
        .select('id, executado, prioridade, periodo, itens(tag, componente), eventos(nome)')
        .eq('folha_tarefa_id', ftId)
        .order('prioridade');
    return (data as List).cast<Map<String, dynamic>>();
  } catch (_) { return []; }
}

class _ItensFTList extends ConsumerWidget {
  const _ItensFTList({required this.ftId, required this.scrollCtrl});
  final String ftId;
  final ScrollController scrollCtrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itens = ref.watch(itensFTProvider(ftId));
    return itens.when(
      loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
      error: (_, __) => const Center(child: Text('Erro ao carregar itens')),
      data: (lista) => ListView.builder(
        controller: scrollCtrl,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: lista.length,
        itemBuilder: (_, i) {
          final item = lista[i];
          final executado = item['executado'] == true;
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            leading: Icon(
              executado ? Icons.check_circle : Icons.radio_button_unchecked,
              color: executado ? IBuildColors.success : IBuildColors.gray300,
              size: 24,
            ),
            title: Text(item['itens']?['tag'] ?? '-',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,
                  decoration: executado ? TextDecoration.lineThrough : null)),
            subtitle: Text('${item['eventos']?['nome'] ?? ''} · P${item['periodo'] ?? '1'}',
              style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),
            trailing: executado ? null : const Icon(Icons.chevron_right,
                color: IBuildColors.gray300),
          );
        },
      ),
    );
  }
}

// ── Nova FT sheet ────────────────────────────────
class _NovaFTSheet extends ConsumerStatefulWidget {
  const _NovaFTSheet({required this.onCriada});
  final VoidCallback onCriada;
  @override
  ConsumerState<_NovaFTSheet> createState() => _NovaFTSheetState();
}

class _NovaFTSheetState extends ConsumerState<_NovaFTSheet> {
  final _seqCtrl = TextEditingController();
  bool _salvando = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20,
          MediaQuery.viewInsetsOf(context).bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Nova Folha Tarefa',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 20),
        TextField(controller: _seqCtrl,
          decoration: const InputDecoration(labelText: 'Número da FT',
              hintText: 'Ex: FT-001')),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _salvando ? null : _salvar,
          child: _salvando
              ? const SizedBox(height: 22, width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Criar Folha Tarefa'),
        ),
      ]),
    );
  }

  Future<void> _salvar() async {
    if (_seqCtrl.text.isEmpty) return;
    setState(() => _salvando = true);
    try {
      final client = ref.read(supabaseProvider);
      final ctx    = ref.read(contextoUsuarioNotifierProvider);
      await client.from('folhas_tarefa').insert({
        'tenant_id':     ctx.tenantId,
        'os_id':         ctx.osId,
        'subprojeto_id': ctx.subprojetoId,
        'sequencial':    _seqCtrl.text.trim(),
        'status':        'aberta',
        'periodo_id':    null, // TODO: seletor de período
        'fase_id':       null, // TODO: seletor de fase
      });
      if (mounted) { Navigator.pop(context); widget.onCriada(); }
    } finally { if (mounted) setState(() => _salvando = false); }
  }
}

// ── Widgets auxiliares ────────────────────────────
class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final (label, cor) = switch (status) {
      'aberta'      => ('Aberta',      IBuildColors.info),
      'em_andamento'=> ('Em andamento',IBuildColors.warning),
      'encerrada'   => ('Encerrada',   IBuildColors.success),
      _             => ('Cancelada',   IBuildColors.error),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, color: cor,
          fontWeight: FontWeight.w600)),
    );
  }
}

class _Vazio extends StatelessWidget {
  const _Vazio();
  @override
  Widget build(BuildContext context) => const Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.assignment_outlined, size: 64, color: IBuildColors.gray300),
      SizedBox(height: 16),
      Text('Nenhuma Folha Tarefa encontrada',
        style: TextStyle(color: IBuildColors.gray500)),
      SizedBox(height: 8),
      Text('Toque em "Nova FT" para criar',
        style: TextStyle(fontSize: 12, color: IBuildColors.gray300)),
    ]),
  );
}

class _Erro extends StatelessWidget {
  const _Erro({required this.erro, required this.onRetry});
  final String erro;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Center(child: Column(
    mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.error_outline, color: IBuildColors.error, size: 48),
      const SizedBox(height: 12),
      const Text('Erro ao carregar dados'),
      TextButton(onPressed: onRetry, child: const Text('Tentar novamente')),
    ],
  ));
}

class _FiltrosSheet extends StatelessWidget {
  const _FiltrosSheet();
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('Filtrar Folhas Tarefa',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      const SizedBox(height: 16),
      ...['Todas', 'Abertas', 'Em andamento', 'Encerradas'].map((s) => ListTile(
        title: Text(s),
        trailing: const Icon(Icons.chevron_right, color: IBuildColors.gray300),
        onTap: () => Navigator.pop(context),
      )),
    ]),
  );
}
