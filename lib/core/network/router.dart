import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../presentation/auth/pages/login_page.dart';
import '../../presentation/auth/pages/selecao_projeto_page.dart';
import '../../presentation/home/pages/home_page.dart';
import '../../presentation/apontamento/pages/apontamento_page.dart';
import '../../presentation/apontamento/pages/scanner_ticket_page.dart';
import '../../presentation/apontamento/pages/confirmar_apontamento_page.dart';
import '../../presentation/folha_tarefa/pages/folha_tarefa_page.dart';
import '../../presentation/eap/pages/eap_page.dart';
import '../../presentation/configuracao/pages/configuracao_page.dart';
import '../../presentation/construcao/pages/detalhamento_page.dart';
import '../../presentation/construcao/pages/selecao_componente_page.dart';
import '../../presentation/planejamento/pages/aprovacao_eap_page.dart';
import '../../presentation/configuracao_sistema/pages/configuracao_sistema_page.dart';
import '../providers/auth_provider.dart';

part 'router.g.dart';

abstract class AppRoutes {
  static const login               = '/login';
  static const selecaoProjeto      = '/selecao-projeto';
  static const home                = '/';
  static const apontamento         = '/apontamento';
  static const scannerTicket       = '/apontamento/scanner';
  static const confirmarApontamento= '/apontamento/confirmar';
  static const folhaTarefa         = '/folha-tarefa';
  static const eap                 = '/eap';
  static const aprovacaoEap        = '/eap/aprovacao';
  static const detalhamento        = '/construcao/detalhamento';
  static const selecaoComponente   = '/construcao/selecao';
  static const configuracao        = '/configuracao';
  static const configuracaoSistema = '/configuracao/sistema';
}

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final isLoggedIn  = authState.valueOrNull != null;
      final isLoginRoute = state.matchedLocation == AppRoutes.login;
      if (!isLoggedIn && !isLoginRoute) return AppRoutes.login;
      if (isLoggedIn  && isLoginRoute)  return AppRoutes.selecaoProjeto;
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login,
          pageBuilder: (_, s) => _fade(const LoginPage(), s)),
      GoRoute(path: AppRoutes.selecaoProjeto,
          pageBuilder: (_, s) => _fade(const SelecaoProjetoPage(), s)),
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => _AppShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.home,
                pageBuilder: (_, s) => _slide(const HomePage(), s)),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.apontamento,
              pageBuilder: (_, s) => _slide(const ApontamentoPage(), s),
              routes: [
                GoRoute(path: 'scanner', pageBuilder: (_, s) => _modal(const ScannerTicketPage(), s)),
                GoRoute(path: 'confirmar', pageBuilder: (_, s) =>
                    _slide(ConfirmarApontamentoPage(ticketId: s.extra as String?), s)),
              ]),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.detalhamento,
              pageBuilder: (_, s) => _slide(const DetalhamentoPage(), s),
              routes: [
                GoRoute(path: 'selecao', pageBuilder: (_, s) => _slide(const SelecaoComponentePage(), s)),
              ]),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.folhaTarefa,
                pageBuilder: (_, s) => _slide(const FolhaTarefaPage(), s)),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.eap,
              pageBuilder: (_, s) => _slide(const EapPage(), s),
              routes: [
                GoRoute(path: 'aprovacao', pageBuilder: (_, s) => _slide(const AprovacaoEapPage(), s)),
              ]),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.configuracao,
              pageBuilder: (_, s) => _slide(const ConfiguracaoPage(), s),
              routes: [
                GoRoute(path: 'sistema', pageBuilder: (_, s) => _slide(const ConfiguracaoSistemaPage(), s)),
              ]),
          ]),
        ],
      ),
    ],
    errorBuilder: (_, s) => Scaffold(
        body: Center(child: Text('Página não encontrada: ${s.error}'))),
  );
}

class _AppShell extends StatelessWidget {
  const _AppShell({required this.shell});
  final StatefulNavigationShell shell;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: shell,
    bottomNavigationBar: NavigationBar(
      selectedIndex: shell.currentIndex,
      onDestinationSelected: shell.goBranch,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Início'),
        NavigationDestination(icon: Icon(Icons.touch_app_outlined), selectedIcon: Icon(Icons.touch_app), label: 'Apontamento'),
        NavigationDestination(icon: Icon(Icons.view_list_outlined), selectedIcon: Icon(Icons.view_list), label: 'Construção'),
        NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment), label: 'FT'),
        NavigationDestination(icon: Icon(Icons.account_tree_outlined), selectedIcon: Icon(Icons.account_tree), label: 'EAP'),
        NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Config'),
      ],
    ),
  );
}

CustomTransitionPage _fade(Widget child, GoRouterState state) =>
    CustomTransitionPage(key: state.pageKey, child: child,
        transitionsBuilder: (_, anim, __, c) => FadeTransition(opacity: anim, child: c));

CustomTransitionPage _slide(Widget child, GoRouterState state) =>
    CustomTransitionPage(key: state.pageKey, child: child,
        transitionsBuilder: (_, anim, __, c) => SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)), child: c));

CustomTransitionPage _modal(Widget child, GoRouterState state) =>
    CustomTransitionPage(key: state.pageKey, child: child, fullscreenDialog: true,
        transitionsBuilder: (_, anim, __, c) => SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: Offset.zero)
              .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)), child: c));
