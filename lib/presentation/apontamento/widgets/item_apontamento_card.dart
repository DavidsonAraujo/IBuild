import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/router.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/apontamento_provider.dart';

// ─────────────────────────────────────────────────────────────
//  Card de item para apontamento
//  Otimizado para uso em campo: texto grande, toque fácil,
//  indicadores visuais claros de status e sync
// ─────────────────────────────────────────────────────────────

class ItemApontamentoCard extends StatelessWidget {
  const ItemApontamentoCard({super.key, required this.item});
  final ItemApontamento item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: item.executado
            ? null
            : () => context.push(
                AppRoutes.confirmarApontamento,
                extra: item.ticketCodigo ?? item.id,
              ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Linha 1: Tag + Status ──────────
              Row(
                children: [
                  // Tag — código do item
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: IBuildColors.primaryLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(item.tag,
                      style: const TextStyle(
                        color: IBuildColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        letterSpacing: 0.3,
                      )),
                  ),

                  const Spacer(),

                  // Status de sync
                  _SyncBadge(status: item.statusSync),

                  const SizedBox(width: 8),

                  // Executado
                  if (item.executado)
                    const Icon(Icons.check_circle,
                        color: IBuildColors.success, size: 22),
                ],
              ),

              const SizedBox(height: 10),

              // ── Linha 2: Componente ─────────────
              if (item.componente != null) ...[
                Text(item.componente!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: IBuildColors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
              ],

              // ── Linha 3: Fase / Evento ──────────
              Row(
                children: [
                  _InfoChip(
                    icon: Icons.layers_outlined,
                    label: item.fase,
                    color: IBuildColors.info,
                  ),
                  const SizedBox(width: 6),
                  _InfoChip(
                    icon: Icons.bolt_outlined,
                    label: item.evento,
                    color: IBuildColors.gray500,
                  ),
                ],
              ),

              // ── Linha 4: Ticket (se houver) ─────
              if (item.ticketCodigo != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.qr_code, size: 14,
                        color: IBuildColors.gray300),
                    const SizedBox(width: 4),
                    Text(item.ticketCodigo!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: IBuildColors.gray500,
                      )),
                  ],
                ),
              ],

              // ── Botão de ação ────────────────────
              if (!item.executado) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: () => context.push(
                      AppRoutes.confirmarApontamento,
                      extra: item.ticketCodigo ?? item.id,
                    ),
                    icon: const Icon(Icons.touch_app, size: 18),
                    label: const Text('Registrar execução'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 44),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Badge de status de sincronização ─────────────
class _SyncBadge extends StatelessWidget {
  const _SyncBadge({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'pendente_sync' => _badge(
          'Pendente sync', IBuildColors.warning, Icons.cloud_upload_outlined),
      'sincronizado'  => const SizedBox.shrink(),
      _               => _badge(
          'Rascunho', IBuildColors.gray300, Icons.edit_outlined),
    };
  }

  Widget _badge(String label, Color color, IconData icon) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 3),
        Text(label,
          style: TextStyle(fontSize: 11, color: color,
              fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

// ── Chip de informação ───────────────────────────
class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 3),
        Text(label,
          style: TextStyle(fontSize: 12, color: color),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
