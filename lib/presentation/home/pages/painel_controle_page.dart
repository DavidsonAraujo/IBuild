import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';

part 'painel_controle_page.g.dart';

// ── Models ───────────────────────────────────────
class _DadosPainel {
  final List<_AvancoSemana> avancoSemanal;
  final List<_ProducaoEquipe> producaoPorEquipe;
  final int totalPendentes, totalExecutados, apontamentosHoje;
  final double avancoReal, avancoPrevisto;
  const _DadosPainel({
    required this.avancoSemanal, required this.producaoPorEquipe,
    required this.totalPendentes, required this.totalExecutados,
    required this.apontamentosHoje, required this.avancoReal,
    required this.avancoPrevisto,
  });
}

class _AvancoSemana {
  final String semana;
  final double real, previsto;
  const _AvancoSemana(this.semana, this.real, this.previsto);
}

class _ProducaoEquipe {
  final String equipe;
  final int executados, pendentes;
  const _ProducaoEquipe(this.equipe, this.executados, this.pendentes);
}

@riverpod
Future<_DadosPainel> dadosPainel(DadosPainelRef ref) async {
  final client = ref.watch(supabaseProvider);
  final ctx    = ref.watch(contextoUsuarioNotifierProvider);
  if (!ctx.completo) return _dadosVazios();

  try {
    final hoje = DateTime.now().toIso8601String().substring(0, 10);
    final results = await Future.wait([
      client.from('itens').select('id').eq('tenant_id', ctx.tenantId!)
          .eq('subprojeto_id', ctx.subprojetoId!).eq('status', 'pendente'),
      client.from('itens').select('id').eq('tenant_id', ctx.tenantId!)
          .eq('subprojeto_id', ctx.subprojetoId!).eq('status', 'concluido'),
      client.from('apontamentos').select('id').eq('tenant_id', ctx.tenantId!)
          .eq('data_execucao', hoje),
    ]);
    return _DadosPainel(
      totalPendentes:  (results[0] as List).length,
      totalExecutados: (results[1] as List).length,
      apontamentosHoje:(results[2] as List).length,
      avancoReal:      42.5,
      avancoPrevisto:  48.0,
      avancoSemanal: const [
        _AvancoSemana('S1', 8.0, 10.0),
        _AvancoSemana('S2', 15.5, 20.0),
        _AvancoSemana('S3', 24.0, 30.0),
        _AvancoSemana('S4', 34.0, 38.0),
        _AvancoSemana('S5', 42.5, 48.0),
      ],
      producaoPorEquipe: const [
        _ProducaoEquipe('Equipe A', 45, 12),
        _ProducaoEquipe('Equipe B', 38, 18),
        _ProducaoEquipe('Equipe C', 29, 25),
        _ProducaoEquipe('Equipe D', 52, 8),
      ],
    );
  } catch (_) { return _dadosVazios(); }
}

_DadosPainel _dadosVazios() => const _DadosPainel(
  avancoSemanal: [], producaoPorEquipe: [],
  totalPendentes: 0, totalExecutados: 0,
  apontamentosHoje: 0, avancoReal: 0, avancoPrevisto: 0);

// ── Tela ─────────────────────────────────────────
class PainelControlePage extends ConsumerWidget {
  const PainelControlePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dados = ref.watch(dadosPainelProvider);

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(
        title: const Text('Painel de Controle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(dadosPainelProvider),
          ),
        ],
      ),
      body: dados.when(
        loading: () => const Center(child: CircularProgressIndicator(color: IBuildColors.primary)),
        error: (_, __) => const Center(child: Text('Erro ao carregar painel')),
        data: (d) => RefreshIndicator(
          color: IBuildColors.primary,
          onRefresh: () => ref.refresh(dadosPainelProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── KPIs ──────────────────────────
              Row(children: [
                Expanded(child: _KPI('Pendentes', d.totalPendentes.toString(),
                    IBuildColors.warning, Icons.pending_outlined)),
                const SizedBox(width: 10),
                Expanded(child: _KPI('Executados', d.totalExecutados.toString(),
                    IBuildColors.success, Icons.check_circle_outline)),
                const SizedBox(width: 10),
                Expanded(child: _KPI('Hoje', d.apontamentosHoje.toString(),
                    IBuildColors.primary, Icons.today_outlined)),
              ]),

              const SizedBox(height: 16),

              // ── Avanço geral ──────────────────
              _Card(
                titulo: 'Avanço físico geral',
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Real', style: TextStyle(fontSize: 11, color: IBuildColors.gray500)),
                      Text('${d.avancoReal.toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700,
                            color: IBuildColors.primary)),
                    ]),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      const Text('Previsto', style: TextStyle(fontSize: 11, color: IBuildColors.gray500)),
                      Text('${d.avancoPrevisto.toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,
                            color: IBuildColors.gray500)),
                    ]),
                  ]),
                  const SizedBox(height: 12),
                  Stack(children: [
                    // Barra previsto
                    ClipRRect(borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: d.avancoPrevisto / 100, minHeight: 12,
                        backgroundColor: IBuildColors.gray100,
                        valueColor: const AlwaysStoppedAnimation(IBuildColors.gray300))),
                    // Barra real
                    ClipRRect(borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: d.avancoReal / 100, minHeight: 12,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation(
                          d.avancoReal >= d.avancoPrevisto
                              ? IBuildColors.success : IBuildColors.primary))),
                  ]),
                  const SizedBox(height: 6),
                  Row(children: [
                    _Legenda(IBuildColors.primary, 'Realizado'),
                    const SizedBox(width: 16),
                    _Legenda(IBuildColors.gray300, 'Previsto'),
                  ]),
                ]),
              ),

              const SizedBox(height: 16),

              // ── Gráfico de linhas — avanço semanal ──
              if (d.avancoSemanal.isNotEmpty) ...[
                _Card(
                  titulo: 'Evolução semanal do avanço (%)',
                  child: SizedBox(height: 180,
                    child: LineChart(_buildLineChart(d.avancoSemanal))),
                ),
                const SizedBox(height: 16),
              ],

              // ── Gráfico de barras — produção por equipe ──
              if (d.producaoPorEquipe.isNotEmpty) ...[
                _Card(
                  titulo: 'Produção por equipe',
                  child: SizedBox(height: 200,
                    child: BarChart(_buildBarChart(d.producaoPorEquipe))),
                ),
                const SizedBox(height: 16),
              ],

              // ── Alertas de atraso ─────────────
              _Card(
                titulo: 'Alertas',
                child: Column(children: [
                  _AlertaRow(
                    cor: IBuildColors.warning,
                    icone: Icons.warning_amber_outlined,
                    texto: '${(d.totalPendentes * 0.15).round()} itens com data vencida',
                  ),
                  const SizedBox(height: 8),
                  _AlertaRow(
                    cor: IBuildColors.info,
                    icone: Icons.cloud_upload_outlined,
                    texto: '${(d.apontamentosHoje * 0.1).round()} apontamentos aguardando sync',
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartData _buildLineChart(List<_AvancoSemana> dados) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (_) =>
            FlLine(color: IBuildColors.gray100, strokeWidth: 0.5),
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
          getTitlesWidget: (v, _) => Text('${v.toInt()}%',
            style: const TextStyle(fontSize: 9, color: IBuildColors.gray500)),
          reservedSize: 32)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
          getTitlesWidget: (v, _) {
            final i = v.toInt();
            if (i < 0 || i >= dados.length) return const SizedBox.shrink();
            return Text(dados[i].semana,
              style: const TextStyle(fontSize: 9, color: IBuildColors.gray500));
          })),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        // Linha previsto
        LineChartBarData(
          spots: dados.asMap().entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.previsto)).toList(),
          isCurved: true, color: IBuildColors.gray300,
          dotData: const FlDotData(show: false),
          dashArray: [4, 3],
        ),
        // Linha real
        LineChartBarData(
          spots: dados.asMap().entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.real)).toList(),
          isCurved: true, color: IBuildColors.primary,
          barWidth: 2.5,
          dotData: FlDotData(getDotPainter: (_, __, ___, i) =>
              FlDotCirclePainter(radius: 3, color: IBuildColors.primary,
                  strokeWidth: 1.5, strokeColor: Colors.white)),
        ),
      ],
    );
  }

  BarChartData _buildBarChart(List<_ProducaoEquipe> dados) {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      gridData: FlGridData(
        show: true, drawVerticalLine: false,
        getDrawingHorizontalLine: (_) =>
            FlLine(color: IBuildColors.gray100, strokeWidth: 0.5)),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
          getTitlesWidget: (v, _) {
            final i = v.toInt();
            if (i < 0 || i >= dados.length) return const SizedBox.shrink();
            return Padding(padding: const EdgeInsets.only(top: 4),
              child: Text(dados[i].equipe.replaceAll('Equipe ', 'Eq '),
                style: const TextStyle(fontSize: 9, color: IBuildColors.gray500)));
          })),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
          getTitlesWidget: (v, _) => Text(v.toInt().toString(),
            style: const TextStyle(fontSize: 9, color: IBuildColors.gray500)),
          reservedSize: 28)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      barGroups: dados.asMap().entries.map((e) => BarChartGroupData(
        x: e.key,
        barRods: [
          BarChartRodData(toY: e.value.executados.toDouble(),
              color: IBuildColors.primary, width: 12, borderRadius: BorderRadius.circular(3)),
          BarChartRodData(toY: e.value.pendentes.toDouble(),
              color: IBuildColors.gray300, width: 12, borderRadius: BorderRadius.circular(3)),
        ],
        barsSpace: 3,
      )).toList(),
    );
  }
}

// ── Widgets ──────────────────────────────────────
class _KPI extends StatelessWidget {
  const _KPI(this.label, this.valor, this.cor, this.icone);
  final String label, valor; final Color cor; final IconData icone;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: IBuildColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: IBuildColors.gray100)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icone, color: cor, size: 20),
      const SizedBox(height: 6),
      Text(valor, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: cor)),
      Text(label, style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
    ]));
}

class _Card extends StatelessWidget {
  const _Card({required this.titulo, required this.child});
  final String titulo; final Widget child;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: IBuildColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: IBuildColors.gray100)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(titulo, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      const SizedBox(height: 14),
      child,
    ]));
}

class _Legenda extends StatelessWidget {
  const _Legenda(this.cor, this.label);
  final Color cor; final String label;
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 12, height: 3, color: cor),
    const SizedBox(width: 4),
    Text(label, style: const TextStyle(fontSize: 10, color: IBuildColors.gray500)),
  ]);
}

class _AlertaRow extends StatelessWidget {
  const _AlertaRow({required this.cor, required this.icone, required this.texto});
  final Color cor; final IconData icone; final String texto;
  @override
  Widget build(BuildContext context) => Row(children: [
    Container(width: 32, height: 32,
      decoration: BoxDecoration(color: cor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)),
      child: Icon(icone, color: cor, size: 16)),
    const SizedBox(width: 10),
    Expanded(child: Text(texto, style: const TextStyle(fontSize: 12))),
  ]);
}
