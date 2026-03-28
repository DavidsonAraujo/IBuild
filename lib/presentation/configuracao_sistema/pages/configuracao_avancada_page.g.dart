// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracao_avancada_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subprojetosHash() => r'496a71982df81b1e6852d7d5e98e7703b37f6e1f';

/// See also [subprojetos].
@ProviderFor(subprojetos)
final subprojetosProvider =
    AutoDisposeFutureProvider<List<_Subprojeto>>.internal(
  subprojetos,
  name: r'subprojetosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$subprojetosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubprojetosRef = AutoDisposeFutureProviderRef<List<_Subprojeto>>;
String _$areasHash() => r'7de0c832b7d544292ec129abf41ebb5687bcf332';

/// See also [areas].
@ProviderFor(areas)
final areasProvider = AutoDisposeFutureProvider<List<_Area>>.internal(
  areas,
  name: r'areasProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$areasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AreasRef = AutoDisposeFutureProviderRef<List<_Area>>;
String _$tabelaGenericaHash() => r'e83b512dff829dc511b452f0cffffba3de2fe01e';

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

/// See also [tabelaGenerica].
@ProviderFor(tabelaGenerica)
const tabelaGenericaProvider = TabelaGenericaFamily();

/// See also [tabelaGenerica].
class TabelaGenericaFamily extends Family<AsyncValue<List<_TabelaItem>>> {
  /// See also [tabelaGenerica].
  const TabelaGenericaFamily();

  /// See also [tabelaGenerica].
  TabelaGenericaProvider call(
    String tabela,
  ) {
    return TabelaGenericaProvider(
      tabela,
    );
  }

  @override
  TabelaGenericaProvider getProviderOverride(
    covariant TabelaGenericaProvider provider,
  ) {
    return call(
      provider.tabela,
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
  String? get name => r'tabelaGenericaProvider';
}

/// See also [tabelaGenerica].
class TabelaGenericaProvider
    extends AutoDisposeFutureProvider<List<_TabelaItem>> {
  /// See also [tabelaGenerica].
  TabelaGenericaProvider(
    String tabela,
  ) : this._internal(
          (ref) => tabelaGenerica(
            ref as TabelaGenericaRef,
            tabela,
          ),
          from: tabelaGenericaProvider,
          name: r'tabelaGenericaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tabelaGenericaHash,
          dependencies: TabelaGenericaFamily._dependencies,
          allTransitiveDependencies:
              TabelaGenericaFamily._allTransitiveDependencies,
          tabela: tabela,
        );

  TabelaGenericaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tabela,
  }) : super.internal();

  final String tabela;

  @override
  Override overrideWith(
    FutureOr<List<_TabelaItem>> Function(TabelaGenericaRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TabelaGenericaProvider._internal(
        (ref) => create(ref as TabelaGenericaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tabela: tabela,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<_TabelaItem>> createElement() {
    return _TabelaGenericaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TabelaGenericaProvider && other.tabela == tabela;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tabela.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TabelaGenericaRef on AutoDisposeFutureProviderRef<List<_TabelaItem>> {
  /// The parameter `tabela` of this provider.
  String get tabela;
}

class _TabelaGenericaProviderElement
    extends AutoDisposeFutureProviderElement<List<_TabelaItem>>
    with TabelaGenericaRef {
  _TabelaGenericaProviderElement(super.provider);

  @override
  String get tabela => (origin as TabelaGenericaProvider).tabela;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
