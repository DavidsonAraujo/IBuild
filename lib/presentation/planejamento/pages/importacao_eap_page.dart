import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';

part 'importacao_eap_page.g.dart';

// ── Model ────────────────────────────────────────
class LinhaEAP {
  final int linha;
  final String codigoWbs, descricao;
  final int nivel;
  final double? peso, quantidade;
  final String? unidade, status;
  final String? erro;
  bool get valida => erro == null;

  const LinhaEAP({
    required this.linha, required this.codigoWbs, required this.descricao,
    required this.nivel, this.peso, this.quantidade, this.unidade,
    this.status, this.erro,
  });
}

class ResultadoImportacao {
  final int total, sucesso, erros;
  final List<LinhaEAP> linhasComErro;
  const ResultadoImportacao({
    required this.total, required this.sucesso,
    required this.erros, required this.linhasComErro,
  });
}

// ── Provider ─────────────────────────────────────
@riverpod
class ImportacaoEapNotifier extends _$ImportacaoEapNotifier {
  @override
  AsyncValue<List<LinhaEAP>?> build() => const AsyncValue.data(null);

  Future<void> selecionarArquivo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'csv'],
    );
    if (result == null || result.files.isEmpty) return;

    state = const AsyncValue.loading();
    try {
      final file = result.files.first;
      final linhas = await _processarArquivo(file);
      state = AsyncValue.data(linhas);
    } catch (e, st) {
      state = AsyncValue.error('Erro ao ler arquivo: $e', st);
    }
  }

  Future<List<LinhaEAP>> _processarArquivo(PlatformFile file) async {
    // Em produção: usar package excel para ler XLSX
    // Por ora retorna dados simulados para demonstração
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      const LinhaEAP(linha: 2, codigoWbs: '1', descricao: 'Tubulação', nivel: 1, peso: 1200, quantidade: 1, unidade: 'CJ'),
      const LinhaEAP(linha: 3, codigoWbs: '1.1', descricao: 'Linha A-001', nivel: 2, peso: 450, quantidade: 15, unidade: 'M'),
      const LinhaEAP(linha: 4, codigoWbs: '1.2', descricao: 'Linha A-002', nivel: 2, peso: 380, quantidade: 12, unidade: 'M'),
      const LinhaEAP(linha: 5, codigoWbs: '1.3', descricao: 'Linha B-001', nivel: 2, peso: 370, quantidade: 11, unidade: 'M'),
      const LinhaEAP(linha: 6, codigoWbs: '2', descricao: 'Estrutura', nivel: 1, peso: 850, quantidade: 1, unidade: 'CJ'),
      const LinhaEAP(linha: 7, codigoWbs: '2.1', descricao: 'Suporte tipo A', nivel: 2, peso: 420, quantidade: 8, unidade: 'UN'),
      const LinhaEAP(linha: 8, codigoWbs: '2.2', descricao: '', nivel: 2, erro: 'Descrição vazia'),
      const LinhaEAP(linha: 9, codigoWbs: '2.3', descricao: 'Suporte tipo C', nivel: 2, peso: 210, quantidade: 4, unidade: 'UN'),
    ];
  }

  Future<ResultadoImportacao> confirmarImportacao(
    List<LinhaEAP> linhas,
    WidgetRef ref,
  ) async {
    final client = ref.read(supabaseProvider);
    final ctx    = ref.read(contextoUsuarioNotifierProvider);
    final uid    = client.auth.currentUser?.id;

    final validas = linhas.where((l) => l.valida).toList();
    int sucesso = 0;
    final erros = <LinhaEAP>[];

    // Registrar processo de importação
    final proc = await client.from('processos').insert({
      'tenant_id': ctx.tenantId, 'tipo': 'importacao_eap',
      'status': 'processando', 'usuario_id': uid,
      'total_registros': validas.length,
    }).select('id').single();
    final procId = proc['id'] as String;

    // Inserir itens em lote
    try {
      final batch = validas.map((l) => {
        'tenant_id':    ctx.tenantId,
        'os_id':        ctx.osId,
        'codigo_wbs':   l.codigoWbs,
        'descricao':    l.descricao,
        'nivel':        l.nivel,
        'peso':         l.peso,
        'quantidade':   l.quantidade,
        'unidade':      l.unidade,
        'status':       'aberto',
      }).toList();

      await client.from('eap_itens').insert(batch);
      sucesso = validas.length;

      // Atualizar processo como concluído
      await client.from('processos').update({
        'status': 'concluido', 'processados': sucesso,
        'concluido_em': DateTime.now().toIso8601String(),
      }).eq('id', procId);

    } catch (e) {
      await client.from('processos').update({
        'status': 'erro', 'log': e.toString(),
      }).eq('id', procId);
      rethrow;
    }

    state = const AsyncValue.data(null);
    return ResultadoImportacao(
      total: linhas.length, sucesso: sucesso,
      erros: linhas.where((l) => !l.valida).length,
      linhasComErro: linhas.where((l) => !l.valida).toList(),
    );
  }

  void limpar() => state = const AsyncValue.data(null);
}

// ── Tela ─────────────────────────────────────────
class ImportacaoEapPage extends ConsumerWidget {
  const ImportacaoEapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(importacaoEapNotifierProvider);

    return Scaffold(
      backgroundColor: IBuildColors.gray100,
      appBar: AppBar(
        title: const Text('Importar EAP'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_outlined),
            tooltip: 'Baixar modelo',
            onPressed: () => _baixarModelo(context),
          ),
        ],
      ),
      body: estado.when(
        loading: () => const _LoadingImportacao(),
        error: (e, _) => _ErroImportacao(erro: e.toString(),
            onTentar: () => ref.read(importacaoEapNotifierProvider.notifier).selecionarArquivo()),
        data: (linhas) => linhas == null
            ? _TelaInicial(
                onSelecionar: () => ref.read(importacaoEapNotifierProvider.notifier).selecionarArquivo(),
              )
            : _PreviewImportacao(
                linhas: linhas,
                onConfirmar: () => _confirmar(context, ref, linhas),
                onCancelar: () => ref.read(importacaoEapNotifierProvider.notifier).limpar(),
              ),
      ),
    );
  }

  Future<void> _confirmar(BuildContext ctx, WidgetRef ref, List<LinhaEAP> linhas) async {
    final validas = linhas.where((l) => l.valida).length;
    final confirm = await showDialog<bool>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar importação'),
        content: Text('Serão importados $validas itens na EAP. Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 40)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Importar'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      final resultado = await ref.read(importacaoEapNotifierProvider.notifier)
          .confirmarImportacao(linhas, ref);
      if (ctx.mounted) _mostrarResultado(ctx, resultado);
    } catch (e) {
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text('Erro: $e'), backgroundColor: IBuildColors.error));
      }
    }
  }

  void _mostrarResultado(BuildContext ctx, ResultadoImportacao r) =>
      showDialog(context: ctx, builder: (_) => AlertDialog(
        title: Row(children: [
          Icon(r.erros == 0 ? Icons.check_circle : Icons.warning_amber,
              color: r.erros == 0 ? IBuildColors.success : IBuildColors.warning),
          const SizedBox(width: 8),
          const Text('Importação concluída'),
        ]),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${r.sucesso} itens importados com sucesso'),
          if (r.erros > 0) Text('${r.erros} linhas ignoradas por erro',
              style: const TextStyle(color: IBuildColors.error)),
        ]),
        actions: [
          ElevatedButton(onPressed: () { Navigator.pop(ctx); Navigator.pop(ctx); },
              child: const Text('Fechar')),
        ],
      ));

  void _baixarModelo(BuildContext ctx) => ScaffoldMessenger.of(ctx).showSnackBar(
    const SnackBar(content: Text('Modelo XLSX disponível na documentação iBuild')));
}

// ── Tela inicial (sem arquivo selecionado) ────────
class _TelaInicial extends StatelessWidget {
  const _TelaInicial({required this.onSelecionar});
  final VoidCallback onSelecionar;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 80, height: 80,
          decoration: BoxDecoration(color: IBuildColors.primaryLight,
              shape: BoxShape.circle),
          child: const Icon(Icons.upload_file, color: IBuildColors.primary, size: 36)),
        const SizedBox(height: 20),
        const Text('Importar planilha EAP',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        const Text(
          'Selecione um arquivo XLSX, XLS ou CSV com a estrutura analítica do projeto.\nUse o modelo para garantir o formato correto.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: IBuildColors.gray500, height: 1.5)),
        const SizedBox(height: 28),
        ElevatedButton.icon(
          onPressed: onSelecionar,
          icon: const Icon(Icons.folder_open_outlined),
          label: const Text('Selecionar arquivo'),
          style: ElevatedButton.styleFrom(minimumSize: const Size(220, 52)),
        ),
        const SizedBox(height: 12),
        // Colunas esperadas
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: IBuildColors.gray100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: IBuildColors.gray300, width: 0.5),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Colunas esperadas:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Wrap(spacing: 8, runSpacing: 4, children: [
              for (final col in ['codigo_wbs', 'descricao', 'nivel', 'peso',
                  'quantidade', 'unidade'])
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: IBuildColors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: IBuildColors.gray300, width: 0.5),
                  ),
                  child: Text(col, style: const TextStyle(
                      fontSize: 11, fontFamily: 'monospace',
                      color: IBuildColors.primary))),
            ]),
          ]),
        ),
      ]),
    ),
  );
}

// ── Preview das linhas lidas ──────────────────────
class _PreviewImportacao extends StatelessWidget {
  const _PreviewImportacao({
    required this.linhas, required this.onConfirmar, required this.onCancelar,
  });
  final List<LinhaEAP> linhas;
  final VoidCallback onConfirmar, onCancelar;

  @override
  Widget build(BuildContext context) {
    final validas = linhas.where((l) => l.valida).length;
    final comErro = linhas.where((l) => !l.valida).length;

    return Column(children: [
      // Barra de resumo
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: IBuildColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: IBuildColors.gray100),
        ),
        child: Row(children: [
          _Stat('Total', linhas.length.toString(), IBuildColors.gray700),
          const SizedBox(width: 20),
          _Stat('Válidas', validas.toString(), IBuildColors.success),
          if (comErro > 0) ...[
            const SizedBox(width: 20),
            _Stat('Com erro', comErro.toString(), IBuildColors.error),
          ],
        ]),
      ),

      // Lista de linhas
      Expanded(child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
        itemCount: linhas.length,
        itemBuilder: (_, i) {
          final linha = linhas[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: linha.valida ? IBuildColors.white : IBuildColors.error.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: linha.valida ? IBuildColors.gray100 : IBuildColors.error.withOpacity(0.3),
                width: 0.5,
              ),
            ),
            child: Row(children: [
              // Nível visual
              SizedBox(width: (linha.nivel - 1) * 16.0),
              Icon(linha.valida ? Icons.check_circle_outline : Icons.error_outline,
                  size: 16,
                  color: linha.valida ? IBuildColors.success : IBuildColors.error),
              const SizedBox(width: 8),
              // WBS
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: IBuildColors.primaryLight,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(linha.codigoWbs,
                  style: const TextStyle(fontSize: 11, fontFamily: 'monospace',
                      fontWeight: FontWeight.w700, color: IBuildColors.primary))),
              const SizedBox(width: 8),
              // Descrição
              Expanded(child: Text(
                linha.erro ?? linha.descricao,
                style: TextStyle(fontSize: 12,
                    color: linha.erro != null ? IBuildColors.error : IBuildColors.black),
                maxLines: 1, overflow: TextOverflow.ellipsis)),
              // Peso / Qtd
              if (linha.peso != null)
                Text('${linha.peso!.toStringAsFixed(0)} kg',
                  style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
            ]),
          );
        },
      )),

      // Botões de ação
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: IBuildColors.white,
          border: Border(top: BorderSide(color: IBuildColors.gray100)),
        ),
        child: Row(children: [
          Expanded(child: OutlinedButton(
            onPressed: onCancelar,
            child: const Text('Cancelar'),
          )),
          const SizedBox(width: 12),
          Expanded(child: ElevatedButton.icon(
            onPressed: validas == 0 ? null : onConfirmar,
            icon: const Icon(Icons.upload, size: 18),
            label: Text('Importar $validas itens'),
          )),
        ]),
      ),
    ]);
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.valor, this.cor);
  final String label, valor;
  final Color cor;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(fontSize: 11, color: IBuildColors.gray500)),
    Text(valor, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: cor)),
  ]);
}

class _LoadingImportacao extends StatelessWidget {
  const _LoadingImportacao();
  @override
  Widget build(BuildContext context) => const Center(child: Column(
    mainAxisSize: MainAxisSize.min, children: [
      CircularProgressIndicator(color: IBuildColors.primary),
      SizedBox(height: 16),
      Text('Processando arquivo...', style: TextStyle(color: IBuildColors.gray500)),
    ],
  ));
}

class _ErroImportacao extends StatelessWidget {
  const _ErroImportacao({required this.erro, required this.onTentar});
  final String erro;
  final VoidCallback onTentar;
  @override
  Widget build(BuildContext context) => Center(child: Padding(
    padding: const EdgeInsets.all(32),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.error_outline, color: IBuildColors.error, size: 48),
      const SizedBox(height: 12),
      Text(erro, textAlign: TextAlign.center,
        style: const TextStyle(color: IBuildColors.gray500, fontSize: 13)),
      const SizedBox(height: 16),
      ElevatedButton(onPressed: onTentar, child: const Text('Tentar novamente')),
    ]),
  ));
}
