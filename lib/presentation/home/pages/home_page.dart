import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';

part 'home_page.g.dart';

// ── Model do dashboard ───────────────────────────
class _DashboardData {
  final int itensPendentes, itensExecutados, apontamentosHoje, ftAbertas;
  final double avancoGeral;
  const _DashboardData({
    required this.itensPendentes, required this.itensExecutados,
    required this.apontamentosHoje, required this.ftAbertas,
    required this.avancoGeral,
  });
}

@riverpod
Future<_DashboardData> dashboardData(DashboardDataRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (!ctx.completo) return const _DashboardData(
    itensPendentes: 0, itensExecutados: 0,
    apontamentosHoje: 0, ftAbertas: 0, avancoGeral: 0);

  try {
    final hoje = DateTime.now().toIso8601String().substring(0, 10);
    final res = await Future.wait([
      client.from('itens').select('id').eq('tenant_id', ctx.tenantId!)
          .eq('subprojeto_id', ctx.subprojetoId!).eq('status', 'pendente'),
      client.from('itens').select('id').eq('tenant_id', ctx.tenantId!)
          .eq('subprojeto_id', ctx.subprojetoId!).eq('status', 'concluido'),
      client.from('apontamentos').select('id').eq('tenant_id', ctx.tenantId!)
          .eq('data_execucao', hoje),
      client.from('folhas_tarefa').select('id').eq('tenant_id', ctx.tenantId!)
          .eq('status', 'aberta'),
    ]);
    return _DashboardData(
      itensPendentes:  (res[0] as List).length,
      itensExecutados: (res[1] as List).length,
      apontamentosHoje:(res[2] as List).length,
      ftAbertas:       (res[3] as List).length,
      avancoGeral:     0,
    );
  } catch (_) {
    return const _DashboardData(
      itensPendentes: 0, itensExecutados: 0,
      apontamentosHoje: 0, ftAbertas: 0, avancoGeral: 0);
  }
}

// ── Tela ─────────────────────────────────────────
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctx   = ref.watch(contextoUsuarioNotifierProvider);
    final dados = ref.watch(dashboardDataProvider);
    final hora  = DateTime.now().hour;
    final saudacao = hora < 12 ? 'Bom dia' : hora < 18 ? 'Boa tarde' : 'Boa noite';

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      body: RefreshIndicator(
        color: IBuildColors.primary,
        onRefresh: () => ref.refresh(dashboardDataProvider.future),
        child: CustomScrollView(
          slivers: [
            // ── AppBar expansível ──────────────
            SliverAppBar(
              expandedHeight: 160,
              floating: false,
              pinned: true,
              backgroundColor: IBuildColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [IBuildColors.primary, IBuildColors.primaryDark],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('$saudacao 👋',
                        style: const TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 4),
                      if (ctx.osNome != null)
                        Text(ctx.osNome!,
                          style: const TextStyle(color: Colors.white,
                              fontSize: 20, fontWeight: FontWeight.w700),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      if (ctx.subprojetoNome != null)
                        Text(ctx.subprojetoNome!,
                          style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.swap_horiz, color: Colors.white),
                  tooltip: 'Trocar projeto',
                  onPressed: () => context.go(AppRoutes.selecaoProjeto),
                ),
              ],
            ),

            // ── Conteúdo ───────────────────────
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(delegate: SliverChildListDelegate([

                // Cards de indicadores
                dados.when(
                  loading: () => const _LoadingCards(),
                  error: (_, __) => const _ErroCard(),
                  data: (d) => Column(children: [
                    // Linha 1
                    Row(children: [
                      Expanded(child: _MetricaCard(
                        valor: d.itensPendentes.toString(),
                        label: 'Itens pendentes',
                        icon: Icons.pending_outlined,
                        cor: IBuildColors.warning,
                        onTap: () => context.go(AppRoutes.apontamento),
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _MetricaCard(
                        valor: d.apontamentosHoje.toString(),
                        label: 'Apontamentos hoje',
                        icon: Icons.touch_app_outlined,
                        cor: IBuildColors.success,
                        onTap: () => context.go(AppRoutes.apontamento),
                      )),
                    ]),
                    const SizedBox(height: 12),
                    // Linha 2
                    Row(children: [
                      Expanded(child: _MetricaCard(
                        valor: d.ftAbertas.toString(),
                        label: 'Folhas Tarefa abertas',
                        icon: Icons.assignment_outlined,
                        cor: IBuildColors.info,
                        onTap: () => context.go(AppRoutes.folhaTarefa),
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _MetricaCard(
                        valor: d.itensExecutados.toString(),
                        label: 'Itens concluídos',
                        icon: Icons.check_circle_outline,
                        cor: IBuildColors.primary,
                        onTap: () => context.go(AppRoutes.eap),
                      )),
                    ]),
                  ]),
                ),

                const SizedBox(height: 24),

                // ── Atalhos rápidos ──────────────
                const Text('Ações rápidas',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
                      color: IBuildColors.gray700)),
                const SizedBox(height: 12),
                _AtalhoCard(
                  icon: Icons.qr_code_scanner,
                  titulo: 'Escanear Ticket',
                  subtitulo: 'Registre execução pelo QR Code',
                  cor: IBuildColors.primary,
                  onTap: () => context.push(AppRoutes.scannerTicket),
                ),
                const SizedBox(height: 8),
                _AtalhoCard(
                  icon: Icons.assignment_add,
                  titulo: 'Nova Folha Tarefa',
                  subtitulo: 'Crie programação de atividades',
                  cor: IBuildColors.info,
                  onTap: () => context.go(AppRoutes.folhaTarefa),
                ),
                const SizedBox(height: 8),
                _AtalhoCard(
                  icon: Icons.account_tree_outlined,
                  titulo: 'Avançar EAP',
                  subtitulo: 'Registre avanço físico na hierarquia',
                  cor: IBuildColors.success,
                  onTap: () => context.go(AppRoutes.eap),
                ),

                const SizedBox(height: 80),
              ])),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricaCard extends StatelessWidget {
  const _MetricaCard({
    required this.valor, required this.label,
    required this.icon, required this.cor, required this.onTap,
  });
  final String valor, label;
  final IconData icon;
  final Color cor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IBuildColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: IBuildColors.gray100),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: cor, size: 24),
        const SizedBox(height: 12),
        Text(valor, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: cor)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),
      ]),
    ),
  );
}

class _AtalhoCard extends StatelessWidget {
  const _AtalhoCard({
    required this.icon, required this.titulo,
    required this.subtitulo, required this.cor, required this.onTap,
  });
  final IconData icon;
  final String titulo, subtitulo;
  final Color cor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IBuildColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: IBuildColors.gray100),
      ),
      child: Row(children: [
        Container(width: 44, height: 44,
          decoration: BoxDecoration(color: cor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: cor, size: 22)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(titulo, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Text(subtitulo, style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),
        ])),
        const Icon(Icons.chevron_right, color: IBuildColors.gray300),
      ]),
    ),
  );
}

class _LoadingCards extends StatelessWidget {
  const _LoadingCards();
  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(padding: EdgeInsets.all(40),
      child: CircularProgressIndicator(color: IBuildColors.primary)));
}

class _ErroCard extends StatelessWidget {
  const _ErroCard();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: IBuildColors.white,
        borderRadius: BorderRadius.circular(12)),
    child: const Row(children: [
      Icon(Icons.wifi_off, color: IBuildColors.gray300),
      SizedBox(width: 12),
      Text('Dados indisponíveis — sem conexão',
        style: TextStyle(color: IBuildColors.gray500, fontSize: 13)),
    ]),
  );
}
