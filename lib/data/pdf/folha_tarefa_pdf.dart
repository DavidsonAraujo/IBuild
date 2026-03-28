import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

// ─────────────────────────────────────────────────────────────
//  Gerador de PDF da Folha Tarefa — iBuild
//  Formatos: Clássico (lista), Ticket (destacável), Documento
// ─────────────────────────────────────────────────────────────

// ── Models de dados para o PDF ───────────────────
class FTDadosPDF {
  final String sequencial, faseNome, osNome, subprojetoNome;
  final DateTime? dataInicio, dataFim;
  final String? equipeNome;
  final List<FTItemPDF> itens;
  const FTDadosPDF({
    required this.sequencial, required this.faseNome,
    required this.osNome, required this.subprojetoNome,
    required this.itens,
    this.dataInicio, this.dataFim, this.equipeNome,
  });
}

class FTItemPDF {
  final String tag, eventoNome, faseNome;
  final String? componente, grupo, subgrupo, ticketCodigo, prioridade, periodo;
  final bool executado;
  final double? peso, comprimento, quantidade;
  const FTItemPDF({
    required this.tag, required this.eventoNome, required this.faseNome,
    this.componente, this.grupo, this.subgrupo, this.ticketCodigo,
    this.prioridade, this.periodo, this.executado = false,
    this.peso, this.comprimento, this.quantidade,
  });
}

enum FormatoFT { classico, ticket, documento }

// ── Serviço de geração de PDF ────────────────────
class FolhaTarefaPdfService {

  static final _ibRed = PdfColor.fromHex('#A51C30');
  static final _gray  = PdfColor.fromHex('#636366');
  static final _light = PdfColor.fromHex('#F2F2F7');
  static final _black = PdfColor.fromHex('#111111');
  static final _white = PdfColors.white;

  // ── Gerar e pré-visualizar ────────────────────
  static Future<void> visualizar(
    FTDadosPDF dados,
    FormatoFT formato,
  ) async {
    final bytes = await gerar(dados, formato);
    await Printing.layoutPdf(onLayout: (_) async => bytes);
  }

  // ── Gerar bytes do PDF ────────────────────────
  static Future<Uint8List> gerar(
    FTDadosPDF dados,
    FormatoFT formato,
  ) async {
    return switch (formato) {
      FormatoFT.classico   => _gerarClassico(dados),
      FormatoFT.ticket     => _gerarTicket(dados),
      FormatoFT.documento  => _gerarDocumento(dados),
    };
  }

  // ─────────────────────────────────────────────
  //  FORMATO CLÁSSICO — lista compacta
  // ─────────────────────────────────────────────
  static Future<Uint8List> _gerarClassico(FTDadosPDF dados) async {
    final pdf  = pw.Document();
    final fmt  = DateFormat('dd/MM/yyyy');
    final itensP1 = dados.itens.where((i) => i.periodo != 'P2').toList();
    final itensP2 = dados.itens.where((i) => i.periodo == 'P2').toList();

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(27, 36, 27, 33),
      header: (ctx) => _cabecalho(dados, ctx),
      footer: (ctx) => _rodape(dados.sequencial, ctx),
      build: (ctx) => [
        // Dados da FT
        _secaoDados(dados, fmt),
        pw.SizedBox(height: 12),

        // Período 1
        if (itensP1.isNotEmpty) ...[
          _tituloPeriodo('P1 — Período 1'),
          pw.SizedBox(height: 6),
          _tabelaClassica(itensP1),
          pw.SizedBox(height: 12),
        ],

        // Período 2
        if (itensP2.isNotEmpty) ...[
          _tituloPeriodo('P2 — Período 2'),
          pw.SizedBox(height: 6),
          _tabelaClassica(itensP2),
        ],

        // Rodapé de totais
        pw.SizedBox(height: 12),
        _totalRow(dados.itens),
      ],
    ));

    return pdf.save();
  }

  // ─────────────────────────────────────────────
  //  FORMATO TICKET — destacável por componente
  // ─────────────────────────────────────────────
  static Future<Uint8List> _gerarTicket(FTDadosPDF dados) async {
    final pdf = pw.Document();
    final fmt = DateFormat('dd/MM/yy');

    // Agrupar por componente para gerar 1 ticket por item
    for (final item in dados.itens) {
      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (ctx) => pw.Column(children: [
          // Borda de corte tracejada
          pw.Container(
            margin: const pw.EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: _gray, width: 0.5,
                style: pw.BorderStyle.dashed,
              ),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
            ),
            child: pw.Column(children: [
              // Header do ticket
              pw.Container(
                color: _ibRed,
                padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('iBuild',
                          style: pw.TextStyle(color: _white,
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                        pw.Text('Folha Tarefa — ${dados.sequencial}',
                          style: pw.TextStyle(color: _white.withOpacity(0.85),
                              fontSize: 10)),
                      ],
                    ),
                    if (item.ticketCodigo != null)
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: pw.BoxDecoration(
                          color: _white.withOpacity(0.15),
                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                        ),
                        child: pw.Text(item.ticketCodigo!,
                          style: pw.TextStyle(color: _white,
                              fontSize: 11, fontWeight: pw.FontWeight.bold,
                              font: pw.Font.courier())),
                      ),
                  ],
                ),
              ),

              // Corpo do ticket
              pw.Padding(
                padding: const pw.EdgeInsets.all(16),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // TAG grande
                    pw.Row(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: pw.BoxDecoration(
                          color: _light,
                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                          border: pw.Border.all(color: _ibRed, width: 0.5),
                        ),
                        child: pw.Text(item.tag,
                          style: pw.TextStyle(fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: _ibRed,
                              font: pw.Font.courier())),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                        child: pw.Text(item.componente ?? '-',
                          style: pw.TextStyle(fontSize: 13,
                              fontWeight: pw.FontWeight.bold, color: _black)),
                      ),
                    ]),

                    pw.SizedBox(height: 12),
                    pw.Divider(color: _light, thickness: 0.5),
                    pw.SizedBox(height: 8),

                    // Dados do item
                    pw.Row(children: [
                      Expanded(child: _dadoTicket('Fase', item.faseNome)),
                      Expanded(child: _dadoTicket('Evento', item.eventoNome)),
                    ]),
                    pw.SizedBox(height: 6),
                    pw.Row(children: [
                      Expanded(child: _dadoTicket('Grupo', item.grupo ?? '-')),
                      Expanded(child: _dadoTicket('Subgrupo', item.subgrupo ?? '-')),
                    ]),
                    pw.SizedBox(height: 6),
                    pw.Row(children: [
                      Expanded(child: _dadoTicket('Período', item.periodo ?? 'P1')),
                      Expanded(child: _dadoTicket('Prioridade', item.prioridade ?? '-')),
                      Expanded(child: _dadoTicket('OS', dados.osNome)),
                    ]),

                    pw.SizedBox(height: 12),
                    pw.Divider(color: _light, thickness: 0.5),
                    pw.SizedBox(height: 8),

                    // Campo de assinatura / data execução
                    pw.Row(children: [
                      pw.Expanded(child: _campoAssinatura('Executado por')),
                      pw.SizedBox(width: 20),
                      pw.Expanded(child: _campoAssinatura('Data execução')),
                      pw.SizedBox(width: 20),
                      pw.Expanded(child: _campoAssinatura('Conferido por')),
                    ]),
                  ],
                ),
              ),
            ]),
          ),
        ]),
      ));
    }

    return pdf.save();
  }

  // ─────────────────────────────────────────────
  //  FORMATO DOCUMENTO — lista de documentos
  // ─────────────────────────────────────────────
  static Future<Uint8List> _gerarDocumento(FTDadosPDF dados) async {
    final pdf = pw.Document();
    final fmt = DateFormat('dd/MM/yyyy');

    // Agrupar documentos distintos (simulado — em produção vem do banco)
    final docs = dados.itens
        .map((i) => '${i.grupo ?? ''} / ${i.subgrupo ?? ''} / ${i.tag}')
        .toSet()
        .toList()
      ..sort();

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(27, 36, 27, 33),
      header: (ctx) => _cabecalho(dados, ctx),
      footer: (ctx) => _rodape(dados.sequencial, ctx),
      build: (ctx) => [
        _secaoDados(dados, fmt),
        pw.SizedBox(height: 16),
        pw.Text('Documentos envolvidos',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold,
              color: _ibRed)),
        pw.SizedBox(height: 8),
        pw.Divider(color: _ibRed, thickness: 0.5),
        pw.SizedBox(height: 8),
        ...docs.asMap().entries.map((e) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 6),
          child: pw.Row(children: [
            pw.Container(
              width: 20, height: 20,
              decoration: pw.BoxDecoration(
                color: _ibRed,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
              ),
              child: pw.Center(child: pw.Text('${e.key + 1}',
                style: pw.TextStyle(color: _white, fontSize: 9,
                    fontWeight: pw.FontWeight.bold))),
            ),
            pw.SizedBox(width: 8),
            pw.Text(e.value, style: pw.TextStyle(fontSize: 10, color: _black)),
          ]),
        )),
      ],
    ));

    return pdf.save();
  }

  // ── Widgets compartilhados ────────────────────

  static pw.Widget _cabecalho(FTDadosPDF dados, pw.Context ctx) =>
      pw.Column(children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Logo texto iBuild
            pw.Row(children: [
              pw.Container(
                width: 24, height: 24,
                decoration: pw.BoxDecoration(
                  shape: pw.BoxShape.circle,
                  border: pw.Border.all(color: _ibRed, width: 2),
                ),
                child: pw.Center(child: pw.Text('i',
                  style: pw.TextStyle(color: _ibRed, fontSize: 12,
                      fontWeight: pw.FontWeight.bold))),
              ),
              pw.SizedBox(width: 6),
              pw.Text('Build', style: pw.TextStyle(fontSize: 18,
                  fontWeight: pw.FontWeight.bold, color: _black)),
            ]),
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
              pw.Text('Folha Tarefa',
                style: pw.TextStyle(fontSize: 14,
                    fontWeight: pw.FontWeight.bold, color: _ibRed)),
              pw.Text(dados.sequencial,
                style: pw.TextStyle(fontSize: 11, color: _gray,
                    font: pw.Font.courier())),
              pw.Text('Pág. ${ctx.pageNumber} de ${ctx.pagesCount}',
                style: pw.TextStyle(fontSize: 8, color: _gray)),
              pw.Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                style: pw.TextStyle(fontSize: 8, color: _gray)),
            ]),
          ],
        ),
        pw.SizedBox(height: 6),
        pw.Divider(color: _ibRed, thickness: 1),
        pw.SizedBox(height: 6),
      ]);

  static pw.Widget _rodape(String seq, pw.Context ctx) =>
      pw.Column(children: [
        pw.Divider(color: _light, thickness: 0.5),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('iBuild — Gestão de Produção',
              style: pw.TextStyle(fontSize: 7, color: _gray)),
            pw.Text('FT-$seq',
              style: pw.TextStyle(fontSize: 7, color: _gray,
                  font: pw.Font.courier())),
          ],
        ),
      ]);

  static pw.Widget _secaoDados(FTDadosPDF dados, DateFormat fmt) =>
      pw.Container(
        padding: const pw.EdgeInsets.all(10),
        decoration: pw.BoxDecoration(
          color: _light,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
        ),
        child: pw.Row(children: [
          Expanded(child: _dado('OS', dados.osNome)),
          Expanded(child: _dado('Subprojeto', dados.subprojetoNome)),
          Expanded(child: _dado('Fase', dados.faseNome)),
          if (dados.dataInicio != null)
            Expanded(child: _dado('Período',
                '${fmt.format(dados.dataInicio!)} → ${dados.dataFim != null ? fmt.format(dados.dataFim!) : "aberto"}')),
          if (dados.equipeNome != null)
            Expanded(child: _dado('Equipe', dados.equipeNome!)),
        ]),
      );

  static pw.Widget _dado(String label, String valor) =>
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(label.toUpperCase(),
          style: pw.TextStyle(fontSize: 7, color: _gray,
              letterSpacing: 0.5, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 2),
        pw.Text(valor, style: pw.TextStyle(fontSize: 9, color: _black)),
      ]);

  static pw.Widget _tituloPeriodo(String titulo) =>
      pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: pw.BoxDecoration(
          color: _ibRed,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
        ),
        child: pw.Text(titulo,
          style: pw.TextStyle(color: _white, fontSize: 9,
              fontWeight: pw.FontWeight.bold)),
      );

  static pw.Widget _tabelaClassica(List<FTItemPDF> itens) =>
      pw.Table(
        border: pw.TableBorder.all(color: _light, width: 0.5),
        columnWidths: {
          0: const pw.FlexColumnWidth(1.2),
          1: const pw.FlexColumnWidth(2.5),
          2: const pw.FlexColumnWidth(1.8),
          3: const pw.FlexColumnWidth(1.5),
          4: const pw.FlexColumnWidth(0.7),
          5: const pw.FlexColumnWidth(0.8),
          6: const pw.FlexColumnWidth(0.8),
        },
        children: [
          // Header
          pw.TableRow(
            decoration: pw.BoxDecoration(color: _ibRed),
            children: [
              _thCell('Tag'), _thCell('Componente'), _thCell('Fase / Evento'),
              _thCell('Grupo'), _thCell('Pri.'), _thCell('Peso'), _thCell('Qtd'),
            ],
          ),
          // Linhas
          ...itens.asMap().entries.map((e) => pw.TableRow(
            decoration: pw.BoxDecoration(
              color: e.key.isEven ? _white : _light.withOpacity(0.4)),
            children: [
              _tdCell(e.value.tag, mono: true),
              _tdCell(e.value.componente ?? '-'),
              _tdCell('${e.value.faseNome}\n${e.value.eventoNome}'),
              _tdCell('${e.value.grupo ?? '-'}\n${e.value.subgrupo ?? ''}'),
              _tdCell(e.value.prioridade ?? '-', center: true),
              _tdCell(e.value.peso?.toStringAsFixed(1) ?? '-', center: true),
              _tdCell(e.value.quantidade?.toStringAsFixed(0) ?? '-', center: true),
            ],
          )),
        ],
      );

  static pw.Widget _totalRow(List<FTItemPDF> itens) {
    final totalPeso = itens.fold<double>(0, (s, i) => s + (i.peso ?? 0));
    final totalQtd  = itens.fold<double>(0, (s, i) => s + (i.quantidade ?? 0));
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: pw.BoxDecoration(
        color: _light,
        border: pw.Border.all(color: _ibRed, width: 0.5),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          pw.Text('Total: ',
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold,
                color: _ibRed)),
          pw.Text('${itens.length} itens  |  ',
            style: pw.TextStyle(fontSize: 9, color: _black)),
          pw.Text('Peso: ${totalPeso.toStringAsFixed(1)} kg  |  ',
            style: pw.TextStyle(fontSize: 9, color: _black)),
          pw.Text('Qtd: ${totalQtd.toStringAsFixed(0)}',
            style: pw.TextStyle(fontSize: 9, color: _black)),
        ],
      ),
    );
  }

  static pw.Widget _thCell(String texto) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 4),
    child: pw.Text(texto.toUpperCase(),
      style: pw.TextStyle(fontSize: 7, color: PdfColors.white,
          fontWeight: pw.FontWeight.bold, letterSpacing: 0.3)),
  );

  static pw.Widget _tdCell(String texto, {bool mono = false, bool center = false}) =>
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: pw.Text(texto,
          textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
          style: pw.TextStyle(fontSize: 8, color: _black,
              font: mono ? pw.Font.courier() : null)),
      );

  static pw.Widget _dadoTicket(String label, String valor) =>
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(label.toUpperCase(),
          style: pw.TextStyle(fontSize: 7, color: _gray,
              letterSpacing: 0.5, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 1),
        pw.Text(valor, style: pw.TextStyle(fontSize: 10, color: _black)),
      ]);

  static pw.Widget _campoAssinatura(String label) =>
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(label.toUpperCase(),
          style: pw.TextStyle(fontSize: 7, color: _gray, letterSpacing: 0.5)),
        pw.SizedBox(height: 20),
        pw.Divider(color: _gray, thickness: 0.5),
      ]);
}

// ── Extensão helper ──────────────────────────────
extension PdfColorOpacity on PdfColor {
  PdfColor withOpacity(double opacity) =>
      PdfColor(red, green, blue, opacity);
}
