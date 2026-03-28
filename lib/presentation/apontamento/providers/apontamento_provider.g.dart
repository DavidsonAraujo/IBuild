// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apontamento_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$conectadoHash() => r'70308e459c1d81a6b387d36c476d085066d569a2';

/// See also [conectado].
@ProviderFor(conectado)
final conectadoProvider = AutoDisposeStreamProvider<bool>.internal(
  conectado,
  name: r'conectadoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$conectadoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConectadoRef = AutoDisposeStreamProviderRef<bool>;
String _$apontamentosNotifierHash() =>
    r'bf09d37d6aec3952da1953a044f9418164bd48c1';

/// See also [ApontamentosNotifier].
@ProviderFor(ApontamentosNotifier)
final apontamentosNotifierProvider = AutoDisposeNotifierProvider<
    ApontamentosNotifier, ApontamentosState>.internal(
  ApontamentosNotifier.new,
  name: r'apontamentosNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apontamentosNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ApontamentosNotifier = AutoDisposeNotifier<ApontamentosState>;
String _$syncNotifierHash() => r'de13302f5ff745ac1e7298c136983a0a32e19b31';

/// See also [SyncNotifier].
@ProviderFor(SyncNotifier)
final syncNotifierProvider =
    AutoDisposeNotifierProvider<SyncNotifier, AsyncValue<void>>.internal(
  SyncNotifier.new,
  name: r'syncNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
