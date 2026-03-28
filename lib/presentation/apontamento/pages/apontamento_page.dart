import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/router.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/apontamento_provider.dart';
import '../widgets/item_apontamento_card.dart';
import '../widgets/status_sync_banner.dart';

// ─────────────────────────────────────────────────────────────
//  Tela de Apontamento de Produção
//  Fluxo: lista de itens pendentes → toca no item → confirma baixa
//         OU escaneia QR code do ticket
// ─────────────────────────────────────────────────────────────

class ApontamentoPage extends ConsumerStatefulWidget {
  const ApontamentoPage({super.key});

  @override
  ConsumerState<ApontamentoPage> createState() => _ApontamentoPageState();
}

class _ApontamentoPageState extends ConsumerState<ApontamentoPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  final _buscaCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _buscaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apontamentos = ref.watch(apontamentosProvider);

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(
        title: const Text('Apontamento'),
        actions: [
          // Status offline
          ref.watch(conectadoProvider).when(
            data: (online) => online
                ? const SizedBox.shrink()
                : const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Chip(
                      label: Text('Offline', style: TextStyle(fontSize: 11)),
                      backgroundColor: IBuildColors.warning,
                      padding: EdgeInsets.zero,
                    ),
                  ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          IconButton(
            icon: const Icon(Icons.sync_outlined),
            tooltip: 'Sincronizar',
            onPressed: () => ref.read(syncProvider.notifier).sincronizar(),
          ),
        ],
        bottom: TabBar(
          controller: _tabCtrl,
          labelColor: IBuildColors.primary,
          indicatorColor: IBuildColors.primary,
          tabs: [
            Tab(text: 'Pendentes (${apontamentos.pendentes.length})'),
            Tab(text: 'Executados (${apontamentos.executados.length})'),
          ],
        ),
      ),

      body: Column(
        children: [
          // ── Banner de sync pendente ────────────
          const StatusSyncBanner(),

          // ── Busca ─────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              controller: _buscaCtrl,
              decoration: InputDecoration(
                hintText: 'Buscar por tag, componente...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _buscaCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _buscaCtrl.clear();
                          ref.read(apontamentosProvider.notifier).filtrar('');
                        },
                      )
                    : null,
              ),
              onChanged: (v) =>
                  ref.read(apontamentosProvider.notifier).filtrar(v),
            ),
          ),

          // ── Listas de itens ───────────────────
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                _ListaItens(
                  itens: apontamentos.pendentes,
                  emptyMsg: 'Nenhum item pendente para este período.',
                  emptyIcon: Icons.check_circle_outline,
                ),
                _ListaItens(
                  itens: apontamentos.executados,
                  emptyMsg: 'Nenhum item executado ainda.',
                  emptyIcon: Icons.hourglass_empty,
                ),
              ],
            ),
          ),
        ],
      ),

      // ── FAB — Scanner QR ───────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.scannerTicket),
        backgroundColor: IBuildColors.primary,
        icon: const Icon(Icons.qr_code_scanner, color: IBuildColors.white),
        label: const Text('Escanear Ticket',
            style: TextStyle(color: IBuildColors.white,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// ── Lista de itens ───────────────────────────────
class _ListaItens extends StatelessWidget {
  const _ListaItens({
    required this.itens,
    required this.emptyMsg,
    required this.emptyIcon,
  });
  final List<ItemApontamento> itens;
  final String emptyMsg;
  final IconData emptyIcon;

  @override
  Widget build(BuildContext context) {
    if (itens.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(emptyIcon, size: 64, color: IBuildColors.gray300),
            const SizedBox(height: 16),
            Text(emptyMsg,
              style: const TextStyle(color: IBuildColors.gray500),
              textAlign: TextAlign.center),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: IBuildColors.primary,
      onRefresh: () async {
        // pull-to-refresh para recarregar do Supabase
      },
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        itemCount: itens.length,
        itemBuilder: (context, i) => ItemApontamentoCard(item: itens[i]),
      ),
    );
  }
}
