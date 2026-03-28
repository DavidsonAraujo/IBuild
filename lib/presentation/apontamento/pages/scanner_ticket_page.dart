import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/network/router.dart';
import '../../../core/theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────
//  Scanner de QR Code — identifica tickets da Folha Tarefa
//  O operador escaneia o ticket físico e vai direto para a
//  tela de confirmar apontamento
// ─────────────────────────────────────────────────────────────

class ScannerTicketPage extends ConsumerStatefulWidget {
  const ScannerTicketPage({super.key});

  @override
  ConsumerState<ScannerTicketPage> createState() => _ScannerTicketPageState();
}

class _ScannerTicketPageState extends ConsumerState<ScannerTicketPage> {
  final _ctrl = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.normal,
  );
  bool _processando = false;
  String? _erro;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onDetected(BarcodeCapture capture) async {
    if (_processando) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    setState(() => _processando = true);
    await _ctrl.stop();

    final ticketCodigo = barcode!.rawValue!;

    // Validar formato do ticket (iBuild-XXXXXXXXXXXX)
    if (!ticketCodigo.startsWith('IBUILD-')) {
      setState(() {
        _erro = 'QR Code inválido. Use tickets gerados pelo iBuild.';
        _processando = false;
      });
      await _ctrl.start();
      return;
    }

    if (mounted) {
      // Navega para confirmação passando o código do ticket
      context.pushReplacement(
        AppRoutes.confirmarApontamento,
        extra: ticketCodigo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IBuildColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: IBuildColors.white,
        title: const Text('Escanear Ticket',
            style: TextStyle(color: IBuildColors.white)),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: _ctrl,
              builder: (_, s, __) => Icon(
                s.torchState == TorchState.on
                    ? Icons.flash_on
                    : Icons.flash_off,
                color: s.torchState == TorchState.on
                    ? IBuildColors.warning
                    : IBuildColors.white,
              ),
            ),
            onPressed: _ctrl.toggleTorch,
          ),
        ],
      ),

      body: Stack(
        children: [
          // ── Camera ───────────────────────────────
          MobileScanner(
            controller: _ctrl,
            onDetect: _onDetected,
          ),

          // ── Overlay de enquadramento ─────────────
          CustomPaint(
            painter: _ScannerOverlayPainter(),
            child: const SizedBox.expand(),
          ),

          // ── Instruções ───────────────────────────
          Positioned(
            bottom: 80,
            left: 0, right: 0,
            child: Column(
              children: [
                if (_erro != null) ...[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: IBuildColors.error.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline,
                            color: IBuildColors.white, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(_erro!,
                            style: const TextStyle(
                                color: IBuildColors.white, fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                const Text(
                  'Aponte para o QR Code no ticket da Folha Tarefa',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: IBuildColors.white, fontSize: 14),
                ),
                const SizedBox(height: 4),
                const Text(
                  'O código começa com IBUILD-',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: IBuildColors.gray300, fontSize: 12),
                ),
              ],
            ),
          ),

          // ── Loading overlay ──────────────────────
          if (_processando)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: IBuildColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Overlay de scanner (moldura customizada) ─────
class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.fill;

    const scanSize = 260.0;
    final cx = size.width / 2;
    final cy = size.height / 2 - 40;
    final rect = Rect.fromCenter(
        center: Offset(cx, cy), width: scanSize, height: scanSize);

    // Escurecer fora da janela de scan
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12)))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);

    // Cantos coloridos
    final corner = Paint()
      ..color = IBuildColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    const cornerLen = 24.0;
    final l = rect.left;
    final t = rect.top;
    final r = rect.right;
    final b = rect.bottom;

    // Canto superior esquerdo
    canvas.drawLine(Offset(l, t + cornerLen), Offset(l, t), corner);
    canvas.drawLine(Offset(l, t), Offset(l + cornerLen, t), corner);
    // Canto superior direito
    canvas.drawLine(Offset(r - cornerLen, t), Offset(r, t), corner);
    canvas.drawLine(Offset(r, t), Offset(r, t + cornerLen), corner);
    // Canto inferior esquerdo
    canvas.drawLine(Offset(l, b - cornerLen), Offset(l, b), corner);
    canvas.drawLine(Offset(l, b), Offset(l + cornerLen, b), corner);
    // Canto inferior direito
    canvas.drawLine(Offset(r - cornerLen, b), Offset(r, b), corner);
    canvas.drawLine(Offset(r, b), Offset(r, b - cornerLen), corner);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
