// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authStateHash() => r'4a7c47de42763666e82202f42a3dfbfd9694c94f';

/// See also [authState].
@ProviderFor(authState)
final authStateProvider = AutoDisposeStreamProvider<User?>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateRef = AutoDisposeStreamProviderRef<User?>;
String _$authServiceHash() => r'31cbf6c5f53fdfa59435e08d52d7b43f26adea86';

/// See also [authService].
@ProviderFor(authService)
final authServiceProvider = AutoDisposeProvider<AuthService>.internal(
  authService,
  name: r'authServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthServiceRef = AutoDisposeProviderRef<AuthService>;
String _$contextoUsuarioNotifierHash() =>
    r'7f52006a04af9976a31b00fd600f8e86fc802c65';

/// See also [ContextoUsuarioNotifier].
@ProviderFor(ContextoUsuarioNotifier)
final contextoUsuarioNotifierProvider = AutoDisposeNotifierProvider<
    ContextoUsuarioNotifier, ContextoUsuario>.internal(
  ContextoUsuarioNotifier.new,
  name: r'contextoUsuarioNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$contextoUsuarioNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ContextoUsuarioNotifier = AutoDisposeNotifier<ContextoUsuario>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
