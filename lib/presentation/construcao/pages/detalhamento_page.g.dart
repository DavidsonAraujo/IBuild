// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detalhamento_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itensConstrucaoHash() => r'69af96d2bf916b71d6ff06029e829df7bc1341c9';

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

/// See also [itensConstrucao].
@ProviderFor(itensConstrucao)
const itensConstrucaoProvider = ItensConstrucaoFamily();

/// See also [itensConstrucao].
class ItensConstrucaoFamily extends Family<AsyncValue<List<ItemConstrucao>>> {
  /// See also [itensConstrucao].
  const ItensConstrucaoFamily();

  /// See also [itensConstrucao].
  ItensConstrucaoProvider call(
    _FiltrosConstrucao filtros,
  ) {
    return ItensConstrucaoProvider(
      filtros,
    );
  }

  @override
  ItensConstrucaoProvider getProviderOverride(
    covariant ItensConstrucaoProvider provider,
  ) {
    return call(
      provider.filtros,
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
  String? get name => r'itensConstrucaoProvider';
}

/// See also [itensConstrucao].
class ItensConstrucaoProvider
    extends AutoDisposeFutureProvider<List<ItemConstrucao>> {
  /// See also [itensConstrucao].
  ItensConstrucaoProvider(
    _FiltrosConstrucao filtros,
  ) : this._internal(
          (ref) => itensConstrucao(
            ref as ItensConstrucaoRef,
            filtros,
          ),
          from: itensConstrucaoProvider,
          name: r'itensConstrucaoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itensConstrucaoHash,
          dependencies: ItensConstrucaoFamily._dependencies,
          allTransitiveDependencies:
              ItensConstrucaoFamily._allTransitiveDependencies,
          filtros: filtros,
        );

  ItensConstrucaoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filtros,
  }) : super.internal();

  final _FiltrosConstrucao filtros;

  @override
  Override overrideWith(
    FutureOr<List<ItemConstrucao>> Function(ItensConstrucaoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItensConstrucaoProvider._internal(
        (ref) => create(ref as ItensConstrucaoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filtros: filtros,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ItemConstrucao>> createElement() {
    return _ItensConstrucaoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItensConstrucaoProvider && other.filtros == filtros;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filtros.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ItensConstrucaoRef on AutoDisposeFutureProviderRef<List<ItemConstrucao>> {
  /// The parameter `filtros` of this provider.
  _FiltrosConstrucao get filtros;
}

class _ItensConstrucaoProviderElement
    extends AutoDisposeFutureProviderElement<List<ItemConstrucao>>
    with ItensConstrucaoRef {
  _ItensConstrucaoProviderElement(super.provider);

  @override
  _FiltrosConstrucao get filtros => (origin as ItensConstrucaoProvider).filtros;
}

String _$filtrosConstrucaoNotifierHash() =>
    r'6bf55f141a5dae7b3de2b60c6a0f12c313b8f7fe';

/// See also [FiltrosConstrucaoNotifier].
@ProviderFor(FiltrosConstrucaoNotifier)
final filtrosConstrucaoNotifierProvider = AutoDisposeNotifierProvider<
    FiltrosConstrucaoNotifier, _FiltrosConstrucao>.internal(
  FiltrosConstrucaoNotifier.new,
  name: r'filtrosConstrucaoNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filtrosConstrucaoNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FiltrosConstrucaoNotifier = AutoDisposeNotifier<_FiltrosConstrucao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
