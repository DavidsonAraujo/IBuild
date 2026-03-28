import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../providers/apontamento_provider.dart';

// Banner que aparece no topo quando há apontamentos
// aguardando sincronização com o servidor
class StatusSyncBanner extends ConsumerWidget {
  const StatusSyncBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state      = ref.watch(apontamentosNotifierProvider);
    final pendentes  = state.pendentesSync;
    final conectado  = ref.watch(conectadoProvider);
    final syncing    = ref.watch(syncProvider);

    if (pendentes == 0) return const SizedBox.shrink();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: conectado.valueOrNull == true
          ? IBuildColors.warning.withOpacity(0.15)
          : IBuildColors.error.withOpacity(0.10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            conectado.valueOrNull == true
                ? Icons.cloud_upload_outlined
                : Icons.cloud_off_outlined,
            size: 16,
            color: conectado.valueOrNull == true
                ? IBuildColors.warning
                : IBuildColors.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              conectado.valueOrNull == true
                  ? '$pendentes apontamento(s) aguardando envio'
                  : '$pendentes apontamento(s) salvos localmente (sem conexão)',
              style: TextStyle(
                fontSize: 12,
                color: conectado.valueOrNull == true
                    ? IBuildColors.warning
                    : IBuildColors.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (conectado.valueOrNull == true)
            syncing.isLoading
                ? const SizedBox(width: 16, height: 16,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: IBuildColors.warning))
                : TextButton(
                    onPressed: () =>
                        ref.read(syncProvider.notifier).sincronizar(),
                    style: TextButton.styleFrom(
                      foregroundColor: IBuildColors.warning,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: const Size(0, 32),
                    ),
                    child: const Text('Enviar agora',
                        style: TextStyle(fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ),
        ],
      ),
    );
  }
}
