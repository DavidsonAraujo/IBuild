import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/network/router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey    = GlobalKey<FormState>();
  final _emailCtrl  = TextEditingController();
  final _senhaCtrl  = TextEditingController();
  bool _loading     = false;
  bool _senhaVisible = false;
  String? _erro;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _erro = null; });

    try {
      await ref.read(authServiceProvider).login(
        email: _emailCtrl.text.trim(),
        senha: _senhaCtrl.text,
      );
      if (mounted) context.go(AppRoutes.selecaoProjeto);
    } catch (e) {
      setState(() => _erro = 'E-mail ou senha inválidos.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: IBuildColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height - 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // ── Logo ─────────────────────────
                _Logo(),

                const SizedBox(height: 48),

                // ── Título ───────────────────────
                Text('Bem-vindo de volta',
                  style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 8),
                Text('Entre com sua conta iBuild para continuar.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: IBuildColors.gray500,
                  )),

                const SizedBox(height: 36),

                // ── Formulário ───────────────────
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Informe o e-mail';
                          if (!v.contains('@')) return 'E-mail inválido';
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Senha
                      TextFormField(
                        controller: _senhaCtrl,
                        obscureText: !_senhaVisible,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _login(),
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_senhaVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: () =>
                                setState(() => _senhaVisible = !_senhaVisible),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Informe a senha';
                          if (v.length < 6) return 'Mínimo 6 caracteres';
                          return null;
                        },
                      ),

                      const SizedBox(height: 8),

                      // Erro
                      if (_erro != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: IBuildColors.error.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline,
                                  color: IBuildColors.error, size: 18),
                              const SizedBox(width: 8),
                              Text(_erro!,
                                style: const TextStyle(
                                    color: IBuildColors.error, fontSize: 13)),
                            ],
                          ),
                        ),

                      // Esqueci senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _esqueciSenha,
                          child: const Text('Esqueci minha senha'),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Botão entrar
                      ElevatedButton(
                        onPressed: _loading ? null : _login,
                        child: _loading
                            ? const SizedBox(
                                height: 22, width: 22,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: IBuildColors.white),
                              )
                            : const Text('Entrar'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ── Rodapé ───────────────────────
                Center(
                  child: Text('iBuild v${AppConstants.appVersion}',
                    style: Theme.of(context).textTheme.bodySmall),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _esqueciSenha() {
    showDialog(
      context: context,
      builder: (ctx) => _EsqueciSenhaDialog(
        onConfirm: (email) async {
          await ref.read(authServiceProvider).redefinirSenha(email);
          if (mounted) {
            Navigator.pop(ctx);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(
                'Link de redefinição enviado para seu e-mail.')));
          }
        },
      ),
    );
  }
}

// ── Logo Component ───────────────────────────────
class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: IBuildColors.primary, width: 2.5),
          ),
          child: const Center(
            child: Text('i',
              style: TextStyle(
                color: IBuildColors.primary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              )),
          ),
        ),
        const SizedBox(width: 10),
        const Text('Build',
          style: TextStyle(
            color: IBuildColors.black,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          )),
      ],
    );
  }
}

// ── Dialog Esqueci Senha ─────────────────────────
class _EsqueciSenhaDialog extends StatefulWidget {
  const _EsqueciSenhaDialog({required this.onConfirm});
  final Future<void> Function(String email) onConfirm;

  @override
  State<_EsqueciSenhaDialog> createState() => _EsqueciSenhaDialogState();
}

class _EsqueciSenhaDialogState extends State<_EsqueciSenhaDialog> {
  final _ctrl = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Redefinir senha'),
      content: TextField(
        controller: _ctrl,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: 'Seu e-mail'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _loading ? null : () async {
            setState(() => _loading = true);
            await widget.onConfirm(_ctrl.text.trim());
          },
          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 42)),
          child: _loading
              ? const SizedBox(height: 18, width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2,
                      color: IBuildColors.white))
              : const Text('Enviar'),
        ),
      ],
    );
  }
}
