// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selecao_componente_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selecoesHash() => r'364118b0b0bd9f9c31fc47e031b5a67da3d9de75';

/// See also [selecoes].
@ProviderFor(selecoes)
final selecoesProvider = AutoDisposeFutureProvider<List<_Selecao>>.internal(
  selecoes,
  name: r'selecoesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selecoesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelecoesRef = AutoDisposeFutureProviderRef<List<_Selecao>>;
String _$itensSelecaoHash() => r'b65904c3913cdca248a8f412f580ef40d11e05b3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [itensSelecao].
@ProviderFor(itensSelecao)
const itensSelecaoProvider = ItensSelecaoFamily();

/// See also [itensSelecao].
class ItensSelecaoFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [itensSelecao].
  const ItensSelecaoFamily();

  /// See also [itensSelecao].
  ItensSelecaoProvider call(
    String selecaoId,
  ) {
    return ItensSelecaoProvider(
      selecaoId,
    );
  }

  @override
  ItensSelecaoProvider getProviderOverride(
    covariant ItensSelecaoProvider provider,
  ) {
    return call(
      provider.selecaoId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'itensSelecaoProvider';
}

/// See also [itensSelecao].
class ItensSelecaoProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [itensSelecao].
  ItensSelecaoProvider(
    String selecaoId,
  ) : this._internal(
          (ref) => itensSelecao(
            ref as ItensSelecaoRef,
            selecaoId,
          ),
          from: itensSelecaoProvider,
          name: r'itensSelecaoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itensSelecaoHash,
          dependencies: ItensSelecaoFamily._dependencies,
          allTransitiveDependencies:
              ItensSelecaoFamily._allTransitiveDependencies,
          selecaoId: selecaoId,
        );

  ItensSelecaoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.selecaoId,
  }) : super.internal();

  final String selecaoId;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(ItensSelecaoRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItensSelecaoProvider._internal(
        (ref) => create(ref as ItensSelecaoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        selecaoId: selecaoId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _ItensSelecaoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItensSelecaoProvider && other.selecaoId == selecaoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, selecaoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ItensSelecaoRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `selecaoId` of this provider.
  String get selecaoId;
}

class _ItensSelecaoProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with ItensSelecaoRef {
  _ItensSelecaoProviderElement(super.provider);

  @override
  String get selecaoId => (origin as ItensSelecaoProvider).selecaoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
