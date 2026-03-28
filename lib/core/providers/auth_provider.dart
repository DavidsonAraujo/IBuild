import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../data/models/contexto_usuario.dart';

part 'auth_provider.g.dart';

// ── Cliente Supabase ─────────────────────────────
final supabaseProvider = Provider<SupabaseClient>((_) => Supabase.instance.client);

// ── Stream de autenticação ───────────────────────
@riverpod
Stream<User?> authState(AuthStateRef ref) {
  final client = ref.watch(supabaseProvider);
  return client.auth.onAuthStateChange.map((event) => event.session?.user);
}

// ── Contexto do usuário logado ───────────────────
// Armazena: tenant, projeto, OS, subprojeto selecionados
@riverpod
class ContextoUsuarioNotifier extends _$ContextoUsuarioNotifier {
  @override
  ContextoUsuario build() => ContextoUsuario.vazio();

  Future<void> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    state = ContextoUsuario(
      tenantId:     prefs.getString(AppConstants.keyTenantId),
      projetoId:    prefs.getString(AppConstants.keyProjetoId),
      osId:         prefs.getString(AppConstants.keyOsId),
      subprojetoId: prefs.getString(AppConstants.keySubprojetoId),
    );
  }

  Future<void> salvar(ContextoUsuario ctx) async {
    final prefs = await SharedPreferences.getInstance();
    if (ctx.tenantId != null)
      await prefs.setString(AppConstants.keyTenantId, ctx.tenantId!);
    if (ctx.projetoId != null)
      await prefs.setString(AppConstants.keyProjetoId, ctx.projetoId!);
    if (ctx.osId != null)
      await prefs.setString(AppConstants.keyOsId, ctx.osId!);
    if (ctx.subprojetoId != null)
      await prefs.setString(AppConstants.keySubprojetoId, ctx.subprojetoId!);
    state = ctx;
  }

  void limpar() => state = ContextoUsuario.vazio();
}

// ── Serviço de autenticação ──────────────────────
@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref.watch(supabaseProvider));
}

class AuthService {
  AuthService(this._client);
  final SupabaseClient _client;

  Future<void> login({required String email, required String senha}) async {
    await _client.auth.signInWithPassword(email: email, password: senha);
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }

  Future<void> redefinirSenha(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  User? get usuarioAtual => _client.auth.currentUser;
  bool get estaLogado => usuarioAtual != null;
}
