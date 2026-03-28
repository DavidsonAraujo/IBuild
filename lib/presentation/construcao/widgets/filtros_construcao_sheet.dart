import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

// ignore_for_file: library_private_types_in_public_api
class FiltrosConstrucaoSheet extends StatefulWidget {
  const FiltrosConstrucaoSheet({super.key, required this.filtrosAtuais, required this.onAplicar});
  final dynamic filtrosAtuais;
  final Function(dynamic) onAplicar;
  @override
  State<FiltrosConstrucaoSheet> createState() => _FiltrosConstrucaoSheetState();
}

class _FiltrosConstrucaoSheetState extends State<FiltrosConstrucaoSheet> {
  late String _status;
  @override
  void initState() { super.initState(); _status = widget.filtrosAtuais.status; }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Text('Filtros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const Spacer(),
        TextButton(onPressed: () => setState(() => _status = 'todos'), child: const Text('Limpar')),
      ]),
      const SizedBox(height: 16),
      const Text('Status', style: TextStyle(fontSize: 12, color: IBuildColors.gray500, fontWeight: FontWeight.w500)),
      const SizedBox(height: 8),
      Wrap(spacing: 8, children: [
        for (final s in [('todos','Todos'), ('pendente','Pendente'), ('em_andamento','Em andamento'), ('concluido','Concluído')])
          FilterChip(
            label: Text(s.$2), selected: _status == s.$1,
            onSelected: (_) => setState(() => _status = s.$1),
            selectedColor: IBuildColors.primaryLight,
            checkmarkColor: IBuildColors.primary,
          ),
      ]),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () { widget.onAplicar(widget.filtrosAtuais); Navigator.pop(context); },
        child: const Text('Aplicar filtros'),
      ),
    ]),
  );
}
