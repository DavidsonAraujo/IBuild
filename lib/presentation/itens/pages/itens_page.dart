// ── Stub: ItensPage ──────────────────────────────
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ItensPage extends StatelessWidget {
  const ItensPage({super.key});
  @override
  Widget build(BuildContext context) => const _BreveStub(
    titulo: 'Detalhamento',
    subtitulo: 'Consulta de componentes e situação',
    icon: Icons.view_list_outlined,
  );
}

// ── Widget genérico de stub (em breve) ───────────
class _BreveStub extends StatelessWidget {
  const _BreveStub({required this.titulo, required this.subtitulo, required this.icon});
  final String titulo, subtitulo;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(titulo)),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 80, height: 80,
        decoration: BoxDecoration(
          color: IBuildColors.primaryLight,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: IBuildColors.primary, size: 36)),
      const SizedBox(height: 20),
      Text(titulo, style: const TextStyle(fontSize: 20,
          fontWeight: FontWeight.w700, color: IBuildColors.black)),
      const SizedBox(height: 8),
      Text(subtitulo, style: const TextStyle(fontSize: 14,
          color: IBuildColors.gray500), textAlign: TextAlign.center),
      const SizedBox(height: 24),
      Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: IBuildColors.primaryLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('Em desenvolvimento — Sprint 3',
          style: TextStyle(fontSize: 12, color: IBuildColors.primary,
              fontWeight: FontWeight.w500))),
    ])),
  );
}
