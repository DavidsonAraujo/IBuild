import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../data/models/contexto_usuario.dart';
import '../../../core/theme/app_theme.dart';

part 'configuracao_avancada_page.g.dart';

// ── Models ───────────────────────────────────────
class _Subprojeto {
  final String id, codigo, nome, status;
  final bool nivelJunta;
  const _Subprojeto({
    required this.id, required this.codigo,
    required this.nome, required this.status, required this.nivelJunta,
  });
}

class _Area {
  final String id, codigo, nome, tipo;
  final String? paiId, paiNome;
  const _Area({
    required this.id, required this.codigo, required this.nome,
    required this.tipo, this.paiId, this.paiNome,
  });
}

class _TabelaItem {
  final String id, chave, descricao, tabela;
  const _TabelaItem({
    required this.id, required this.chave,
    required this.descricao, required this.tabela,
  });
}

// ── Providers ────────────────────────────────────
@riverpod
Future<List<_Subprojeto>> subprojetos(SubprojetosRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (!ctx.completo) return [];
  try {
    final data = await client.from('subprojetos')
        .select('id, codigo, nome, status, nivel_junta')
        .eq('tenant_id', ctx.tenantId!)
        .eq('os_id', ctx.osId!)
        .order('codigo');
    return (data as List).map((r) => _Subprojeto(
      id: r['id'], codigo: r['codigo'], nome: r['nome'],
      status: r['status'] ?? 'ativo', nivelJunta: r['nivel_junta'] ?? false,
    )).toList();
  } catch (_) { return []; }
}

@riverpod
Future<List<_Area>> areas(AreasRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (!ctx.completo) return [];
  try {
    final data = await client.from('areas')
        .select('id, codigo, nome, tipo, pai_id')
        .eq('tenant_id', ctx.tenantId!)
        .eq('subprojeto_id', ctx.subprojetoId!)
        .order('tipo').order('codigo');
    return (data as List).map((r) => _Area(
      id: r['id'], codigo: r['codigo'], nome: r['nome'], tipo: r['tipo'],
      paiId: r['pai_id'],
    )).toList();
  } catch (_) { return []; }
}

@riverpod
Future<List<_TabelaItem>> tabelaGenerica(TabelaGenericaRef ref, String tabela) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (ctx.tenantId == null) return [];
  // Simulado — em produção buscar da tabela genérica real
  await Future.delayed(const Duration(milliseconds: 200));
  return switch (tabela) {
    'EQUIPE' => [
      const _TabelaItem(id: '1', chave: 'EQ01', descricao: 'Equipe Tubulação A', tabela: 'EQUIPE'),
      const _TabelaItem(id: '2', chave: 'EQ02', descricao: 'Equipe Tubulação B', tabela: 'EQUIPE'),
      const _TabelaItem(id: '3', chave: 'EQ03', descricao: 'Equipe Estrutura',  tabela: 'EQUIPE'),
    ],
    'LOCAL_SOLDAGEM' => [
      const _TabelaItem(id: '4', chave: 'LS01', descricao: 'Área Industrial',   tabela: 'LOCAL_SOLDAGEM'),
      const _TabelaItem(id: '5', chave: 'LS02', descricao: 'Área de Manutenção',tabela: 'LOCAL_SOLDAGEM'),
    ],
    'ENSAIO' => [
      const _TabelaItem(id: '6', chave: 'RX',   descricao: 'Radiografia',       tabela: 'ENSAIO'),
      const _TabelaItem(id: '7', chave: 'US',   descricao: 'Ultrassom',          tabela: 'ENSAIO'),
      const _TabelaItem(id: '8', chave: 'LP',   descricao: 'Líquido Penetrante', tabela: 'ENSAIO'),
    ],
    _ => [],
  };
}

// ── Tela principal ───────────────────────────────
class ConfiguracaoAvancadaPage extends ConsumerStatefulWidget {
  const ConfiguracaoAvancadaPage({super.key});
  @override
  ConsumerState<ConfiguracaoAvancadaPage> createState() => _State();
}

class _State extends ConsumerState<ConfiguracaoAvancadaPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  @override
  void initState() { super.initState(); _tab = TabController(length: 4, vsync: this); }
  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: IBuildColors.gray100,
    appBar: AppBar(
      title: const Text('Configuração avançada'),
      bottom: TabBar(
        controller: _tab,
        labelColor: IBuildColors.primary,
        indicatorColor: IBuildColors.primary,
        isScrollable: true,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Subprojetos'),
          Tab(text: 'Áreas'),
          Tab(text: 'Tabelas'),
          Tab(text: 'Autorização de Serviço'),
        ],
      ),
    ),
    body: TabBarView(controller: _tab, children: [
      _SubprojetosTab(onAdd: () => _novoSubprojeto(context)),
      _AreasTab(onAdd: () => _novaArea(context)),
      _TabelasTab(),
      _ASTab(),
    ]),
  );

  void _novoSubprojeto(BuildContext ctx) => showDialog(
    context: ctx,
    builder: (_) => _FormDialog(
      titulo: 'Novo Subprojeto',
      campos: const [
        _Campo('Código', 'codigo'),
        _Campo('Nome', 'nome'),
      ],
      onSalvar: (vals) async {
        final client = ref.read(supabaseProvider);
        final ctx2   = ref.read(contextoUsuarioNotifierProvider);
        await client.from('subprojetos').insert({
          'tenant_id': ctx2.tenantId, 'os_id': ctx2.osId,
          'codigo': vals['codigo'], 'nome': vals['nome'], 'status': 'ativo',
        });
        ref.invalidate(subprojetosProvider);
      },
    ),
  );

  void _novaArea(BuildContext ctx) => showDialog(
    context: ctx,
    builder: (_) => _FormDialog(
      titulo: 'Nova Área',
      campos: const [
        _Campo('Código', 'codigo'),
        _Campo('Nome', 'nome'),
      ],
      onSalvar: (vals) async {
        final client = ref.read(supabaseProvider);
        final ctx2   = ref.read(contextoUsuarioNotifierProvider);
        await client.from('areas').insert({
          'tenant_id': ctx2.tenantId, 'subprojeto_id': ctx2.subprojetoId,
          'codigo': vals['codigo'], 'nome': vals['nome'], 'tipo': 'area',
        });
        ref.invalidate(areasProvider);
      },
    ),
  );
}

// ── Tab Subprojetos ──────────────────────────────
class _SubprojetosTab extends ConsumerWidget {
  const _SubprojetosTab({required this.onAdd});
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lista = ref.watch(subprojetosProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: lista.when(
        loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
        error: (_, __) => const Center(child: Text('Erro')),
        data: (subs) => subs.isEmpty
            ? _Vazio(label: 'Nenhum subprojeto', onAdd: onAdd)
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
                itemCount: subs.length,
                itemBuilder: (_, i) {
                  final s = subs[i];
                  return Card(margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: IBuildColors.primaryLight,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(s.codigo, style: const TextStyle(fontSize: 12,
                            color: IBuildColors.primary, fontWeight: FontWeight.w700))),
                      title: Text(s.nome, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      subtitle: Row(children: [
                        _StatusPill(s.status),
                        if (s.nivelJunta) ...[
                          const SizedBox(width: 6),
                          const _Pill('Controle de Juntas', IBuildColors.info),
                        ],
                      ]),
                      trailing: PopupMenuButton<String>(
                        onSelected: (_) {},
                        itemBuilder: (_) => [
                          const PopupMenuItem(value: 'editar', child: Text('Editar')),
                          const PopupMenuItem(value: 'inativar', child: Text('Inativar')),
                        ],
                      ),
                    ));
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd, backgroundColor: IBuildColors.primary,
        child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}

// ── Tab Áreas ────────────────────────────────────
class _AreasTab extends ConsumerWidget {
  const _AreasTab({required this.onAdd});
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lista = ref.watch(areasProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: lista.when(
        loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
        error: (_, __) => const Center(child: Text('Erro')),
        data: (areas) {
          // Agrupar por tipo
          final grupos = <String, List<_Area>>{};
          for (final a in areas) {
            grupos.putIfAbsent(a.tipo, () => []).add(a);
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
            children: grupos.entries.map((e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(e.key.toUpperCase(),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                        color: IBuildColors.gray500, letterSpacing: 0.5))),
                ...e.value.map((a) => Card(margin: const EdgeInsets.only(bottom: 4),
                  child: ListTile(dense: true,
                    leading: Text(a.codigo, style: const TextStyle(
                        fontSize: 12, fontFamily: 'monospace',
                        fontWeight: FontWeight.w700, color: IBuildColors.primary)),
                    title: Text(a.nome, style: const TextStyle(fontSize: 13)),
                    trailing: const Icon(Icons.chevron_right, color: IBuildColors.gray300, size: 16),
                    onTap: () {},
                  ))),
              ],
            )).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd, backgroundColor: IBuildColors.primary,
        child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}

// ── Tab Tabelas Genéricas ─────────────────────────
class _TabelasTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<_TabelasTab> createState() => _TabelasTabState();
}

class _TabelasTabState extends ConsumerState<_TabelasTab> {
  String _tabelaSel = 'EQUIPE';
  final _tabelas = ['EQUIPE', 'LOCAL_SOLDAGEM', 'ENSAIO'];

  @override
  Widget build(BuildContext context) {
    final itens = ref.watch(tabelaGenericaProvider(_tabelaSel));
    return Column(children: [
      // Seletor de tabela
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Row(children: _tabelas.map((t) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FilterChip(
            label: Text(t, style: const TextStyle(fontSize: 12)),
            selected: _tabelaSel == t,
            onSelected: (_) => setState(() => _tabelaSel = t),
            selectedColor: IBuildColors.primaryLight,
            checkmarkColor: IBuildColors.primary,
          ),
        )).toList()),
      ),
      Expanded(child: itens.when(
        loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
        error: (_, __) => const Center(child: Text('Erro')),
        data: (lista) => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: lista.length + 1,
          itemBuilder: (_, i) {
            if (i == lista.length) return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: OutlinedButton.icon(
                onPressed: () => _novoItem(context),
                icon: const Icon(Icons.add, size: 16),
                label: Text('Novo item em $_tabelaSel'),
              ),
            );
            final item = lista[i];
            return Card(margin: const EdgeInsets.only(bottom: 4),
              child: ListTile(dense: true,
                leading: Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(color: IBuildColors.primaryLight,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(item.chave, style: const TextStyle(fontSize: 11,
                      color: IBuildColors.primary, fontWeight: FontWeight.w700,
                      fontFamily: 'monospace'))),
                title: Text(item.descricao, style: const TextStyle(fontSize: 13)),
                trailing: IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 16, color: IBuildColors.gray500),
                  onPressed: () {},
                ),
              ));
          },
        ),
      )),
    ]);
  }

  void _novoItem(BuildContext ctx) => showDialog(
    context: ctx,
    builder: (_) => AlertDialog(
      title: Text('Novo item — $_tabelaSel'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const TextField(decoration: InputDecoration(labelText: 'Chave / Código')),
        const SizedBox(height: 8),
        const TextField(decoration: InputDecoration(labelText: 'Descrição')),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(80, 40)),
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
}

// ── Tab AS ────────────────────────────────────────
class _ASTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(supabaseProvider).from('ordens_servico')
          .select('id, codigo, nome, ativo')
          .eq('tenant_id', ref.read(contextoUsuarioNotifierProvider).tenantId ?? '')
          .order('codigo'),
      builder: (ctx, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: IBuildColors.primary));
        final lista = (snap.data as List).cast<Map<String, dynamic>>();
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
          itemCount: lista.length,
          itemBuilder: (_, i) {
            final os = lista[i];
            return Card(margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: IBuildColors.primaryLight,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(os['codigo'] ?? '', style: const TextStyle(
                      fontSize: 12, color: IBuildColors.primary,
                      fontWeight: FontWeight.w700, fontFamily: 'monospace'))),
                title: Text(os['nome'] ?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                subtitle: Text(os['ativo'] == true ? 'Ativa' : 'Inativa',
                  style: TextStyle(fontSize: 11,
                      color: os['ativo'] == true ? IBuildColors.success : IBuildColors.error)),
                trailing: const Icon(Icons.chevron_right, color: IBuildColors.gray300, size: 16),
                onTap: () {},
              ));
          },
        );
      },
    );
  }
}

// ── Widgets auxiliares ────────────────────────────
class _StatusPill extends StatelessWidget {
  const _StatusPill(this.status);
  final String status;
  @override
  Widget build(BuildContext context) {
    final (cor, label) = switch (status) {
      'ativo'    => (IBuildColors.success, 'Ativo'),
      'pausado'  => (IBuildColors.warning, 'Pausado'),
      _          => (IBuildColors.error, 'Encerrado'),
    };
    return _Pill(label, cor);
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.label, this.cor);
  final String label; final Color cor;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(color: cor.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: cor, fontWeight: FontWeight.w600)));
}

class _Vazio extends StatelessWidget {
  const _Vazio({required this.label, required this.onAdd});
  final String label; final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) => Center(child: Column(
    mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.inbox_outlined, size: 64, color: IBuildColors.gray300),
      const SizedBox(height: 16),
      Text(label, style: const TextStyle(color: IBuildColors.gray500)),
      const SizedBox(height: 12),
      ElevatedButton.icon(onPressed: onAdd,
        icon: const Icon(Icons.add, size: 18), label: const Text('Adicionar'),
        style: ElevatedButton.styleFrom(minimumSize: const Size(0, 44))),
    ],
  ));
}

// ── Dialog genérico de formulário ────────────────
class _Campo { final String label, chave; const _Campo(this.label, this.chave); }

class _FormDialog extends StatefulWidget {
  const _FormDialog({required this.titulo, required this.campos, required this.onSalvar});
  final String titulo;
  final List<_Campo> campos;
  final Future<void> Function(Map<String, String>) onSalvar;
  @override
  State<_FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<_FormDialog> {
  late final Map<String, TextEditingController> _ctrls;
  bool _salvando = false;
  @override
  void initState() {
    super.initState();
    _ctrls = {for (final c in widget.campos) c.chave: TextEditingController()};
  }
  @override
  void dispose() { for (final c in _ctrls.values) c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.titulo),
    content: Column(mainAxisSize: MainAxisSize.min,
      children: widget.campos.asMap().entries.map((e) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextField(controller: _ctrls[e.value.chave],
          decoration: InputDecoration(labelText: e.value.label),
          autofocus: e.key == 0),
      )).toList()),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
      ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(80, 40)),
        onPressed: _salvando ? null : () async {
          if (_ctrls.values.any((c) => c.text.isEmpty)) return;
          setState(() => _salvando = true);
          try {
            await widget.onSalvar({for (final e in _ctrls.entries) e.key: e.value.text.trim()});
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
