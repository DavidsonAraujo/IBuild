import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/contexto_usuario.dart';

part 'selecao_projeto_page.g.dart';

// ── Models locais ────────────────────────────────
class _Projeto  { final String id, codigo, nome; const _Projeto({required this.id, required this.codigo, required this.nome}); }
class _OS       { final String id, codigo, nome; const _OS({required this.id, required this.codigo, required this.nome}); }
class _Subprojeto { final String id, codigo, nome; const _Subprojeto({required this.id, required this.codigo, required this.nome}); }

// ── Providers ────────────────────────────────────
@riverpod
Future<List<_Projeto>> projetos(ProjetosRef ref) async {
  final client = ref.watch(supabaseProvider);
  final uid    = client.auth.currentUser?.id;
  if (uid == null) return [];
  final data = await client.from('projetos').select('id, codigo, nome').eq('status', 'ativo').order('nome');
  return (data as List).map((r) => _Projeto(id: r['id'], codigo: r['codigo'], nome: r['nome'])).toList();
}

@riverpod
Future<List<_OS>> ordens(OrdensRef ref, String projetoId) async {
  final client = ref.watch(supabaseProvider);
  final data = await client.from('ordens_servico')
      .select('id, codigo, nome')
      .eq('projeto_id', projetoId)
      .eq('ativo', true)
      .order('codigo');
  return (data as List).map((r) => _OS(id: r['id'], codigo: r['codigo'], nome: r['nome'])).toList();
}

@riverpod
Future<List<_Subprojeto>> subprojetos(SubprojetosRef ref, String osId) async {
  final client = ref.watch(supabaseProvider);
  final data = await client.from('subprojetos')
      .select('id, codigo, nome')
      .eq('os_id', osId)
      .eq('status', 'ativo')
      .order('codigo');
  return (data as List).map((r) => _Subprojeto(id: r['id'], codigo: r['codigo'], nome: r['nome'])).toList();
}

// ── Tela ─────────────────────────────────────────
class SelecaoProjetoPage extends ConsumerStatefulWidget {
  const SelecaoProjetoPage({super.key});
  @override
  ConsumerState<SelecaoProjetoPage> createState() => _SelecaoProjetoPageState();
}

class _SelecaoProjetoPageState extends ConsumerState<SelecaoProjetoPage> {
  _Projeto?    _projeto;
  _OS?         _os;
  _Subprojeto? _sub;
  bool         _salvando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IBuildColors.white,
      appBar: AppBar(
        title: const Text('Selecionar projeto'),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(authServiceProvider).logout();
              if (mounted) context.go(AppRoutes.login);
            },
            child: const Text('Sair', style: TextStyle(color: IBuildColors.error)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo compacto
              Row(children: [
                Container(width: 32, height: 32,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                      border: Border.all(color: IBuildColors.primary, width: 2)),
                  child: const Center(child: Text('i',
                      style: TextStyle(color: IBuildColors.primary,
                          fontSize: 16, fontWeight: FontWeight.w700)))),
                const SizedBox(width: 8),
                const Text('Build', style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w700, color: IBuildColors.black)),
              ]),
              const SizedBox(height: 32),
              Text('Em qual projeto\nvocê vai trabalhar?',
                style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 8),
              Text('Selecione o projeto, OS e subprojeto para continuar.',
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: IBuildColors.gray500)),
              const SizedBox(height: 36),

              // ── Seletor de Projeto ────────────
              _SelecionarCard(
                titulo: 'Projeto',
                valor: _projeto == null ? null : '[${_projeto!.codigo}] ${_projeto!.nome}',
                placeholder: 'Selecione o projeto',
                icon: Icons.work_outline,
                onTap: () => _selecionarProjeto(context),
              ),
              const SizedBox(height: 12),

              // ── Seletor de OS ─────────────────
              _SelecionarCard(
                titulo: 'Ordem de Serviço',
                valor: _os == null ? null : '[${_os!.codigo}] ${_os!.nome}',
                placeholder: 'Selecione a OS',
                icon: Icons.assignment_outlined,
                habilitado: _projeto != null,
                onTap: _projeto == null ? null : () => _selecionarOS(context),
              ),
              const SizedBox(height: 12),

              // ── Seletor de Subprojeto ─────────
              _SelecionarCard(
                titulo: 'Subprojeto / Disciplina',
                valor: _sub == null ? null : '[${_sub!.codigo}] ${_sub!.nome}',
                placeholder: 'Selecione o subprojeto',
                icon: Icons.layers_outlined,
                habilitado: _os != null,
                onTap: _os == null ? null : () => _selecionarSubprojeto(context),
              ),

              const Spacer(),

              // ── Botão Continuar ───────────────
              ElevatedButton(
                onPressed: (_projeto != null && _os != null && _sub != null && !_salvando)
                    ? _confirmar : null,
                child: _salvando
                    ? const SizedBox(height: 22, width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2, color: IBuildColors.white))
                    : const Text('Entrar no projeto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmar() async {
    setState(() => _salvando = true);
    await ref.read(contextoUsuarioNotifierProvider.notifier).salvar(
      ContextoUsuario(
        projetoId:      _projeto!.id,
        projetoNome:    _projeto!.nome,
        osId:           _os!.id,
        osNome:         _os!.nome,
        subprojetoId:   _sub!.id,
        subprojetoNome: _sub!.nome,
      ),
    );
    if (mounted) context.go(AppRoutes.home);
  }

  Future<void> _selecionarProjeto(BuildContext ctx) async {
    final data = await ref.read(projetosProvider.future);
    if (!mounted) return;
    final sel = await _showBottomSheet<_Projeto>(ctx,
      titulo: 'Selecionar Projeto',
      itens: data,
      labelFn: (p) => '[${p.codigo}] ${p.nome}',
    );
    if (sel != null) setState(() { _projeto = sel; _os = null; _sub = null; });
  }

  Future<void> _selecionarOS(BuildContext ctx) async {
    final data = await ref.read(ordensProvider(_projeto!.id).future);
    if (!mounted) return;
    final sel = await _showBottomSheet<_OS>(ctx,
      titulo: 'Selecionar OS',
      itens: data,
      labelFn: (o) => '[${o.codigo}] ${o.nome}',
    );
    if (sel != null) setState(() { _os = sel; _sub = null; });
  }

  Future<void> _selecionarSubprojeto(BuildContext ctx) async {
    final data = await ref.read(subprojetosProvider(_os!.id).future);
    if (!mounted) return;
    final sel = await _showBottomSheet<_Subprojeto>(ctx,
      titulo: 'Selecionar Subprojeto',
      itens: data,
      labelFn: (s) => '[${s.codigo}] ${s.nome}',
    );
    if (sel != null) setState(() => _sub = sel);
  }

  Future<T?> _showBottomSheet<T>(BuildContext ctx, {
    required String titulo,
    required List<T> itens,
    required String Function(T) labelFn,
  }) => showModalBottomSheet<T>(
    context: ctx,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (_, ctrl) => Column(children: [
        const SizedBox(height: 12),
        Container(width: 40, height: 4,
            decoration: BoxDecoration(color: IBuildColors.gray300,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 16),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(titulo, style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600))),
        const SizedBox(height: 8),
        const Divider(),
        Expanded(child: ListView.builder(
          controller: ctrl,
          itemCount: itens.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(labelFn(itens[i])),
            trailing: const Icon(Icons.chevron_right, color: IBuildColors.gray300),
            onTap: () => Navigator.pop(ctx, itens[i]),
          ),
        )),
      ]),
    ),
  );
}

class _SelecionarCard extends StatelessWidget {
  const _SelecionarCard({
    required this.titulo, required this.placeholder,
    required this.icon, required this.onTap,
    this.valor, this.habilitado = true,
  });
  final String titulo, placeholder;
  final String? valor;
  final IconData icon;
  final VoidCallback? onTap;
  final bool habilitado;

  @override
  Widget build(BuildContext context) {
    final selecionado = valor != null;
    return Opacity(
      opacity: habilitado ? 1.0 : 0.4,
      child: InkWell(
        onTap: habilitado ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selecionado ? IBuildColors.primary : IBuildColors.gray300,
              width: selecionado ? 1.5 : 0.5,
            ),
            color: selecionado ? IBuildColors.primaryLight : IBuildColors.white,
          ),
          child: Row(children: [
            Icon(icon, color: selecionado ? IBuildColors.primary : IBuildColors.gray500, size: 22),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(titulo, style: TextStyle(fontSize: 11,
                  color: selecionado ? IBuildColors.primary : IBuildColors.gray500,
                  fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(valor ?? placeholder,
                style: TextStyle(fontSize: 14,
                    color: selecionado ? IBuildColors.primary : IBuildColors.gray300,
                    fontWeight: selecionado ? FontWeight.w600 : FontWeight.w400)),
            ])),
            Icon(Icons.expand_more,
                color: selecionado ? IBuildColors.primary : IBuildColors.gray300),
          ]),
        ),
      ),
    );
  }
}
