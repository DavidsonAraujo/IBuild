import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/apontamento_provider.dart';

part 'confirmar_apontamento_page.g.dart';

@riverpod
Future<Map<String, dynamic>?> dadosTicket(DadosTicketRef ref, String? codigo) async {
  if (codigo == null) return null;
  final client = ref.watch(supabaseProvider);
  try {
    final data = await client.from('tickets')
        .select('id, codigo, numero, folha_tarefa_id, folhas_tarefa(sequencial, fases(nome))')
        .eq('codigo', codigo)
        .maybeSingle();
    return data;
  } catch (_) { return null; }
}

class ConfirmarApontamentoPage extends ConsumerStatefulWidget {
  const ConfirmarApontamentoPage({super.key, this.ticketId});
  final String? ticketId;
  @override
  ConsumerState<ConfirmarApontamentoPage> createState() => _State();
}

class _State extends ConsumerState<ConfirmarApontamentoPage> {
  double _qtd = 1;
  DateTime _dataExec = DateTime.now();
  final _obsCtrl = TextEditingController();
  bool _salvando = false;

  @override
  void dispose() { _obsCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final ticket = ref.watch(dadosTicketProvider(widget.ticketId));

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(
        title: const Text('Confirmar Apontamento'),
        leading: IconButton(icon: const Icon(Icons.close),
            onPressed: () => context.pop()),
      ),
      body: ticket.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: IBuildColors.primary)),
        error: (_, __) => _Erro(onVoltar: () => context.pop()),
        data: (dados) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ── Info do ticket ─────────────────
            if (dados != null) _TicketInfoCard(dados: dados)
            else _SemTicketCard(codigo: widget.ticketId),

            const SizedBox(height: 16),

            // ── Data de execução ───────────────
            _SecaoCard(titulo: 'Data de execução', children: [
              InkWell(
                onTap: _selecionarData,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: IBuildColors.gray100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: IBuildColors.gray300, width: 0.5),
                  ),
                  child: Row(children: [
                    const Icon(Icons.calendar_today_outlined,
                        color: IBuildColors.gray500, size: 18),
                    const SizedBox(width: 10),
                    Text('${_dataExec.day.toString().padLeft(2,'0')}/'
                        '${_dataExec.month.toString().padLeft(2,'0')}/'
                        '${_dataExec.year}',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    const Icon(Icons.expand_more, color: IBuildColors.gray300),
                  ]),
                ),
              ),
            ]),

            const SizedBox(height: 12),

            // ── Quantidade ─────────────────────
            _SecaoCard(titulo: 'Quantidade executada', children: [
              Row(children: [
                IconButton(
                  onPressed: () => setState(() => _qtd = (_qtd - 1).clamp(0, 999)),
                  icon: const Icon(Icons.remove_circle_outline),
                  color: IBuildColors.primary,
                  iconSize: 32,
                ),
                Expanded(child: Text(_qtd.toStringAsFixed(0),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700,
                      color: IBuildColors.primary))),
                IconButton(
                  onPressed: () => setState(() => _qtd = (_qtd + 1).clamp(0, 999)),
                  icon: const Icon(Icons.add_circle_outline),
                  color: IBuildColors.primary,
                  iconSize: 32,
                ),
              ]),
            ]),

            const SizedBox(height: 12),

            // ── Observação ─────────────────────
            _SecaoCard(titulo: 'Observação (opcional)', children: [
              TextField(
                controller: _obsCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Digite alguma observação...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ]),

            const SizedBox(height: 32),

            // ── Botão confirmar ────────────────
            ElevatedButton.icon(
              onPressed: _salvando ? null : () => _confirmar(dados),
              icon: const Icon(Icons.check_circle_outline),
              label: _salvando
                  ? const SizedBox(height: 22, width: 22,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Confirmar execução'),
            ),

            const SizedBox(height: 16),

            OutlinedButton(
              onPressed: () => context.pop(),
              child: const Text('Cancelar'),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _confirmar(Map<String, dynamic>? dados) async {
    setState(() => _salvando = true);
    try {
      await ref.read(apontamentosNotifierProvider.notifier).registrar(
        itemId:       dados?['item_id'] ?? '',
        eventoId:     dados?['evento_id'] ?? '',
        ticketId:     dados?['id'],
        qtdRealizada: _qtd,
        dataExecucao: _dataExec,
        observacao:   _obsCtrl.text.trim().isEmpty ? null : _obsCtrl.text.trim(),
      );
      if (mounted) {
        _mostrarSucesso();
        Future.delayed(const Duration(seconds: 2),
            () { if (mounted) context.go(AppRoutes.apontamento); });
      }
    } finally { if (mounted) setState(() => _salvando = false); }
  }

  void _mostrarSucesso() => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Row(children: [
        Icon(Icons.check_circle, color: Colors.white),
        SizedBox(width: 8),
        Text('Apontamento registrado com sucesso!'),
      ]),
      backgroundColor: IBuildColors.success,
      duration: const Duration(seconds: 2),
    ),
  );

  Future<void> _selecionarData() async {
    final sel = await showDatePicker(
      context: context,
      initialDate: _dataExec,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    );
    if (sel != null) setState(() => _dataExec = sel);
  }
}

class _TicketInfoCard extends StatelessWidget {
  const _TicketInfoCard({required this.dados});
  final Map<String, dynamic> dados;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: IBuildColors.primaryLight,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: IBuildColors.primary.withOpacity(0.3)),
    ),
    child: Row(children: [
      const Icon(Icons.qr_code, color: IBuildColors.primary, size: 32),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(dados['codigo'] ?? '',
          style: const TextStyle(fontFamily: 'monospace', fontSize: 13,
              fontWeight: FontWeight.w700, color: IBuildColors.primary)),
        const SizedBox(height: 2),
        Text(dados['folhas_tarefa']?['fases']?['nome'] ?? '-',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        Text('FT ${dados['folhas_tarefa']?['sequencial'] ?? ''}',
          style: const TextStyle(fontSize: 12, color: IBuildColors.gray500)),
      ])),
    ]),
  );
}

class _SemTicketCard extends StatelessWidget {
  const _SemTicketCard({this.codigo});
  final String? codigo;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: IBuildColors.warning.withOpacity(0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: IBuildColors.warning.withOpacity(0.3)),
    ),
    child: Row(children: [
      const Icon(Icons.warning_amber_outlined, color: IBuildColors.warning),
      const SizedBox(width: 12),
      Expanded(child: Text(
        codigo != null ? 'Ticket: $codigo' : 'Apontamento manual (sem ticket)',
        style: const TextStyle(color: IBuildColors.warning, fontWeight: FontWeight.w500))),
    ]),
  );
}

class _SecaoCard extends StatelessWidget {
  const _SecaoCard({required this.titulo, required this.children});
  final String titulo;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: IBuildColors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: IBuildColors.gray100),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(titulo, style: const TextStyle(fontSize: 12,
          color: IBuildColors.gray500, fontWeight: FontWeight.w500)),
      const SizedBox(height: 10),
      ...children,
    ]),
  );
}

class _Erro extends StatelessWidget {
  const _Erro({required this.onVoltar});
  final VoidCallback onVoltar;
  @override
  Widget build(BuildContext context) => Center(child: Column(
    mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.qr_code_2, size: 64, color: IBuildColors.gray300),
      const SizedBox(height: 16),
      const Text('Ticket não encontrado'),
      const SizedBox(height: 8),
      ElevatedButton(onPressed: onVoltar,
          child: const Text('Voltar e tentar novamente')),
    ],
  ));
}
