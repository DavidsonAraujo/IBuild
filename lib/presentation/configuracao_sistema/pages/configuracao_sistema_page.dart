import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';

part 'configuracao_sistema_page.g.dart';

// ── Models ───────────────────────────────────────
class _Disciplina {
  final String id, codigo, nome, tipo;
  final bool ativo;
  const _Disciplina({required this.id, required this.codigo,
      required this.nome, required this.tipo, required this.ativo});
}

class _Evento {
  final String id, codigo, nome, faseNome;
  final double? percentual;
  final int ordem;
  const _Evento({required this.id, required this.codigo, required this.nome,
      required this.faseNome, this.percentual, required this.ordem});
}

class _FaseTemplate {
  final String id, codigo, nome;
  final int totalEventos;
  const _FaseTemplate({required this.id, required this.codigo,
      required this.nome, required this.totalEventos});
}

// ── Providers ────────────────────────────────────
@riverpod
Future<List<_Disciplina>> disciplinas(DisciplinasRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (ctx.tenantId == null) return [];
  try {
    final data = await client.from('disciplinas')
        .select().eq('tenant_id', ctx.tenantId!).order('codigo');
    return (data as List).map((r) => _Disciplina(
      id: r['id'], codigo: r['codigo'], nome: r['nome'],
      tipo: r['tipo'] ?? 'componente', ativo: r['ativo'] ?? true,
    )).toList();
  } catch (_) { return []; }
}

@riverpod
Future<List<_FaseTemplate>> fases(FasesRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (ctx.tenantId == null) return [];
  try {
    final data = await client.from('fases')
        .select('id, codigo, nome, eventos(id)')
        .eq('tenant_id', ctx.tenantId!)
        .order('codigo');
    return (data as List).map((r) => _FaseTemplate(
      id: r['id'], codigo: r['codigo'], nome: r['nome'],
      totalEventos: (r['eventos'] as List?)?.length ?? 0,
    )).toList();
  } catch (_) { return []; }
}

@riverpod
Future<List<_Evento>> eventosDaFase(EventosDaFaseRef ref, String faseId) async {
  final client = ref.watch(supabaseProvider);
  try {
    final data = await client.from('eventos')
        .select('id, codigo, nome, percentual, ordem, fases(nome)')
        .eq('fase_id', faseId)
        .order('ordem');
    return (data as List).map((r) => _Evento(
      id: r['id'], codigo: r['codigo'], nome: r['nome'],
      faseNome: r['fases']?['nome'] ?? '',
      percentual: r['percentual']?.toDouble(),
      ordem: r['ordem'] ?? 0,
    )).toList();
  } catch (_) { return []; }
}

// ── Tela principal de Configuração do Sistema ────
class ConfiguracaoSistemaPage extends ConsumerStatefulWidget {
  const ConfiguracaoSistemaPage({super.key});
  @override
  ConsumerState<ConfiguracaoSistemaPage> createState() => _State();
}

class _State extends ConsumerState<ConfiguracaoSistemaPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  @override
  void initState() { super.initState(); _tab = TabController(length: 3, vsync: this); }
  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: IBuildColors.gray100,
    appBar: AppBar(
      title: const Text('Configuração do sistema'),
      bottom: TabBar(
        controller: _tab,
        labelColor: IBuildColors.primary,
        indicatorColor: IBuildColors.primary,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Disciplinas'),
          Tab(text: 'Fases'),
          Tab(text: 'Eventos'),
        ],
      ),
    ),
    body: TabBarView(controller: _tab, children: [
      _DisciplinasTab(onAdd: () => _novaDisciplina(context)),
      _FasesTab(onAdd: () => _novaFase(context)),
      _EventosTab(),
    ]),
  );

  void _novaDisciplina(BuildContext ctx) => showDialog(
    context: ctx,
    builder: (_) => _FormDialog(
      titulo: 'Nova Disciplina',
      campos: const ['Código', 'Nome'],
      onSalvar: (vals) async {
        final client = ref.read(supabaseProvider);
        final ctx2   = ref.read(contextoUsuarioNotifierProvider);
        await client.from('disciplinas').insert({
          'tenant_id': ctx2.tenantId, 'codigo': vals[0], 'nome': vals[1], 'tipo': 'componente',
        });
        ref.invalidate(disciplinasProvider);
      },
    ),
  );

  void _novaFase(BuildContext ctx) => showDialog(
    context: ctx,
    builder: (_) => _FormDialog(
      titulo: 'Nova Fase',
      campos: const ['Código', 'Nome'],
      onSalvar: (vals) async {
        final client = ref.read(supabaseProvider);
        final ctx2   = ref.read(contextoUsuarioNotifierProvider);
        await client.from('fases').insert({
          'tenant_id': ctx2.tenantId, 'codigo': vals[0], 'nome': vals[1],
        });
        ref.invalidate(fasesProvider);
      },
    ),
  );
}

// ── Aba Disciplinas ──────────────────────────────
class _DisciplinasTab extends ConsumerWidget {
  const _DisciplinasTab({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lista = ref.watch(disciplinasProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: lista.when(
        loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
        error: (_, __) => const Center(child: Text('Erro ao carregar')),
        data: (items) => ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
          itemCount: items.length,
          itemBuilder: (_, i) => _ConfigCard(
            codigo: items[i].codigo, nome: items[i].nome,
            info: items[i].tipo,
            ativo: items[i].ativo,
            onTap: () {},
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        backgroundColor: IBuildColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// ── Aba Fases ────────────────────────────────────
class _FasesTab extends ConsumerWidget {
  const _FasesTab({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lista = ref.watch(fasesProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: lista.when(
        loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
        error: (_, __) => const Center(child: Text('Erro ao carregar')),
        data: (items) => ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
          itemCount: items.length,
          itemBuilder: (_, i) => _ConfigCard(
            codigo: items[i].codigo, nome: items[i].nome,
            info: '${items[i].totalEventos} evento(s)',
            onTap: () => _verEventos(context, ref, items[i]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        backgroundColor: IBuildColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _verEventos(BuildContext ctx, WidgetRef ref, _FaseTemplate fase) =>
      showModalBottomSheet(
        context: ctx, isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => _EventosDaFaseSheet(fase: fase),
      );
}

// ── Sheet de eventos de uma fase ─────────────────
class _EventosDaFaseSheet extends ConsumerWidget {
  const _EventosDaFaseSheet({required this.fase});
  final _FaseTemplate fase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventos = ref.watch(eventosDaFaseProvider(fase.id));
    return DraggableScrollableSheet(
      initialChildSize: 0.7, maxChildSize: 0.95, minChildSize: 0.4, expand: false,
      builder: (_, ctrl) => Column(children: [
        const SizedBox(height: 12),
        Container(width: 40, height: 4,
            decoration: BoxDecoration(color: IBuildColors.gray300,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 16),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(fase.nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text('[${fase.codigo}] · ${fase.totalEventos} evento(s)',
              style: const TextStyle(fontSize: 13, color: IBuildColors.gray500)),
          ])),
          IconButton(icon: const Icon(Icons.add_circle_outline, color: IBuildColors.primary),
              onPressed: () {}),
        ])),
        const Divider(height: 20),
        Expanded(child: eventos.when(
          loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
          error: (_, __) => const Center(child: Text('Erro')),
          data: (lista) => ReorderableListView.builder(
            scrollController: ctrl,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: lista.length,
            onReorder: (_, __) {}, // TODO: reordenar
            itemBuilder: (_, i) {
              final e = lista[i];
              return ListTile(
                key: Key(e.id),
                contentPadding: EdgeInsets.zero,
                leading: Container(width: 32, height: 32,
                  decoration: BoxDecoration(color: IBuildColors.primaryLight,
                      borderRadius: BorderRadius.circular(6)),
                  child: Center(child: Text('${e.ordem}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                          color: IBuildColors.primary)))),
                title: Text(e.nome, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                subtitle: e.percentual != null
                    ? Text('${e.percentual!.toStringAsFixed(0)}%',
                        style: const TextStyle(fontSize: 11, color: IBuildColors.gray500))
                    : null,
                trailing: const Icon(Icons.drag_handle, color: IBuildColors.gray300),
              );
            },
          ),
        )),
      ]),
    );
  }
}

// ── Aba Eventos (visão geral) ────────────────────
class _EventosTab extends ConsumerWidget {
  _EventosTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fases = ref.watch(fasesProvider);
    return fases.when(
      loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
      error: (_, __) => const Center(child: Text('Erro')),
      data: (lista) => ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        itemCount: lista.length,
        itemBuilder: (_, i) => ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: IBuildColors.white,
          collapsedBackgroundColor: IBuildColors.white,
          leading: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: IBuildColors.primaryLight,
                borderRadius: BorderRadius.circular(4)),
            child: Text(lista[i].codigo, style: const TextStyle(fontSize: 11,
                color: IBuildColors.primary, fontWeight: FontWeight.w700))),
          title: Text(lista[i].nome,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          subtitle: Text('${lista[i].totalEventos} evento(s)',
            style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
          children: [
            _EventosExpanded(faseId: lista[i].id),
          ],
        ),
      ),
    );
  }
}

class _EventosExpanded extends ConsumerWidget {
  const _EventosExpanded({required this.faseId});
  final String faseId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventos = ref.watch(eventosDaFaseProvider(faseId));
    return eventos.when(
      loading: () => const Padding(padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(color: IBuildColors.primary)),
      error: (_, __) => const SizedBox.shrink(),
      data: (lista) => Column(
        children: lista.map((e) => ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          dense: true,
          leading: Text('${e.ordem}'.padLeft(2, '0'),
            style: const TextStyle(fontSize: 12, color: IBuildColors.gray500,
                fontWeight: FontWeight.w600)),
          title: Text(e.nome, style: const TextStyle(fontSize: 13)),
          trailing: e.percentual != null
              ? Text('${e.percentual!.toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                      color: IBuildColors.primary))
              : null,
        )).toList(),
      ),
    );
  }
}

// ── Card de configuração genérico ─────────────────
class _ConfigCard extends StatelessWidget {
  const _ConfigCard({required this.codigo, required this.nome,
      required this.info, required this.onTap, this.ativo = true});
  final String codigo, nome, info;
  final bool ativo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 8),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(padding: const EdgeInsets.all(14), child: Row(children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: ativo ? IBuildColors.primaryLight : IBuildColors.gray100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(codigo, style: TextStyle(fontSize: 12,
              color: ativo ? IBuildColors.primary : IBuildColors.gray500,
              fontWeight: FontWeight.w700, fontFamily: 'monospace'))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(nome, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
              color: ativo ? IBuildColors.black : IBuildColors.gray500)),
          Text(info, style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),
        ])),
        if (!ativo) const Padding(
          padding: EdgeInsets.only(right: 4),
          child: Text('Inativo', style: TextStyle(fontSize: 11, color: IBuildColors.gray300)),
        ),
        const Icon(Icons.chevron_right, color: IBuildColors.gray300, size: 18),
      ])),
    ),
  );
}

// ── Dialog genérico de formulário ────────────────
class _FormDialog extends StatefulWidget {
  const _FormDialog({required this.titulo, required this.campos, required this.onSalvar});
  final String titulo;
  final List<String> campos;
  final Future<void> Function(List<String>) onSalvar;
  @override
  State<_FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<_FormDialog> {
  late final List<TextEditingController> _ctrls;
  bool _salvando = false;
  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(widget.campos.length, (_) => TextEditingController());
  }
  @override
  void dispose() { for (final c in _ctrls) c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.titulo),
    content: Column(mainAxisSize: MainAxisSize.min,
      children: widget.campos.asMap().entries.map((e) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(controller: _ctrls[e.key],
            decoration: InputDecoration(labelText: e.value),
            autofocus: e.key == 0),
      )).toList()),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
      ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(80, 40)),
        onPressed: _salvando ? null : () async {
          if (_ctrls.any((c) => c.text.isEmpty)) return;
          setState(() => _salvando = true);
          try {
            await widget.onSalvar(_ctrls.map((c) => c.text.trim()).toList());
            if (mounted) Navigator.pop(context);
          } finally { if (mounted) setState(() => _salvando = false); }
        },
        child: _salvando
            ? const SizedBox(height: 18, width: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : const Text('Salvar'),
      ),
    ],
  );
}
