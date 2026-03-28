// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncServiceHash() => r'e73798a106ad79d5004a589d89b8973a28c93b47';

/// See also [syncService].
@ProviderFor(syncService)
final syncServiceProvider = AutoDisposeProvider<SyncService>.internal(
  syncService,
  name: r'syncServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncServiceRef = AutoDisposeProviderRef<SyncService>;
String _$syncEstadoHash() => r'b3143922886d47958db127b62838a72fc76a1312';

/// See also [SyncEstado].
@ProviderFor(SyncEstado)
final syncEstadoProvider =
    AutoDisposeNotifierProvider<SyncEstado, AsyncValue<SyncResult?>>.internal(
  SyncEstado.new,
  name: r'syncEstadoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncEstadoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncEstado = AutoDisposeNotifier<AsyncValue<SyncResult?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
