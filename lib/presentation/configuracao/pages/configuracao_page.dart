import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';

part 'configuracao_page.g.dart';

@riverpod
Future<PackageInfo> packageInfo(PackageInfoRef ref) =>
    PackageInfo.fromPlatform();

class ConfiguracaoPage extends ConsumerWidget {
  const ConfiguracaoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(supabaseProvider);
    final user   = client.auth.currentUser;
    final ctx    = ref.watch(contextoUsuarioNotifierProvider);
    final pkg    = ref.watch(packageInfoProvider);

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          // ── Perfil ──────────────────────────
          const _Secao(titulo: 'Perfil'),
          _ItemConfig(
            icon: Icons.person_outline,
            titulo: user?.email ?? 'Usuário',
            subtitulo: ctx.subprojetoNome ?? 'Selecione um subprojeto',
            trailing: const Icon(Icons.chevron_right, color: IBuildColors.gray300),
            onTap: () {},
          ),

          // ── Projeto atual ────────────────────
          const _Secao(titulo: 'Projeto'),
          _ItemConfig(
            icon: Icons.work_outline,
            titulo: ctx.osNome ?? 'Nenhum projeto',
            subtitulo: ctx.subprojetoNome ?? '-',
            trailing: TextButton(
              onPressed: () => context.go(AppRoutes.selecaoProjeto),
              child: const Text('Trocar'),
            ),
            onTap: () => context.go(AppRoutes.selecaoProjeto),
          ),

          // ── Aparência ────────────────────────
          const _Secao(titulo: 'Aparência'),
          _ItemConfig(
            icon: Icons.dark_mode_outlined,
            titulo: 'Modo escuro',
            subtitulo: 'Ideal para uso em campo com luz solar',
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              activeColor: IBuildColors.primary,
              onChanged: (_) {}, // TODO: persistir preferência
            ),
            onTap: null,
          ),

          // ── Dados offline ────────────────────
          const _Secao(titulo: 'Dados offline'),
          _ItemConfig(
            icon: Icons.sync_outlined,
            titulo: 'Sincronizar agora',
            subtitulo: 'Enviar apontamentos pendentes',
            trailing: const Icon(Icons.chevron_right, color: IBuildColors.gray300),
            onTap: () {},
          ),
          _ItemConfig(
            icon: Icons.storage_outlined,
            titulo: 'Limpar cache local',
            subtitulo: 'Apaga dados offline do dispositivo',
            trailing: const Icon(Icons.chevron_right, color: IBuildColors.error),
            onTap: () => _confirmarLimparCache(context),
          ),

          // ── Sobre ────────────────────────────
          const _Secao(titulo: 'Sobre'),
          pkg.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (info) => _ItemConfig(
              icon: Icons.info_outline,
              titulo: 'iBuild',
              subtitulo: 'Versão ${info.version} (${info.buildNumber})',
              onTap: null,
            ),
          ),

          // ── Sair ────────────────────────────
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () => _confirmarLogout(context, ref),
              icon: const Icon(Icons.logout, color: IBuildColors.error),
              label: const Text('Sair da conta',
                  style: TextStyle(color: IBuildColors.error)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: IBuildColors.error),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _confirmarLogout(BuildContext ctx, WidgetRef ref) => showDialog(
    context: ctx,
    builder: (_) => AlertDialog(
      title: const Text('Sair da conta'),
      content: const Text(
          'Tem certeza? Apontamentos não sincronizados serão perdidos.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: IBuildColors.error,
              minimumSize: const Size(80, 40)),
          onPressed: () async {
            await ref.read(authServiceProvider).logout();
            if (ctx.mounted) { Navigator.pop(ctx); ctx.go(AppRoutes.login); }
          },
          child: const Text('Sair'),
        ),
      ],
    ),
  );

  void _confirmarLimparCache(BuildContext ctx) => showDialog(
    context: ctx,
    builder: (_) => AlertDialog(
      title: const Text('Limpar cache'),
      content: const Text(
          'Os dados offline serão removidos. Apontamentos não sincronizados serão perdidos.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: IBuildColors.error,
              minimumSize: const Size(80, 40)),
          onPressed: () { Navigator.pop(ctx); /* TODO: limpar Drift */ },
          child: const Text('Limpar'),
        ),
      ],
    ),
  );
}

class _Secao extends StatelessWidget {
  const _Secao({required this.titulo});
  final String titulo;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
    child: Text(titulo.toUpperCase(),
      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
          color: IBuildColors.gray500, letterSpacing: 0.8)),
  );
}

class _ItemConfig extends StatelessWidget {
  const _ItemConfig({
    required this.icon, required this.titulo,
    this.subtitulo, this.trailing, this.onTap,
  });
  final IconData icon;
  final String titulo;
  final String? subtitulo;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    decoration: BoxDecoration(
      color: IBuildColors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      leading: Icon(icon, color: IBuildColors.gray500, size: 22),
      title: Text(titulo, style: const TextStyle(fontSize: 14,
          fontWeight: FontWeight.w500)),
      subtitle: subtitulo != null
          ? Text(subtitulo!, style: const TextStyle(fontSize: 12,
              color: IBuildColors.gray500))
          : null,
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),
  );
}
