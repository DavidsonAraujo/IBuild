import 'package:freezed_annotation/freezed_annotation.dart';

part 'contexto_usuario.freezed.dart';

@freezed
class ContextoUsuario with _$ContextoUsuario {
  const factory ContextoUsuario({
    String? tenantId,
    String? projetoId,
    String? osId,
    String? subprojetoId,
    String? projetoNome,
    String? osNome,
    String? subprojetoNome,
  }) = _ContextoUsuario;

  factory ContextoUsuario.vazio() => const ContextoUsuario();
}

extension ContextoUsuarioX on ContextoUsuario {
  bool get completo =>
      tenantId != null && osId != null && subprojetoId != null;
}
