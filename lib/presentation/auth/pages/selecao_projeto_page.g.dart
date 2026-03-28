// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selecao_projeto_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projetosHash() => r'7516bfbffbd873c6c7ff5ac46db5b35a1e780be3';

/// See also [projetos].
@ProviderFor(projetos)
final projetosProvider = AutoDisposeFutureProvider<List<_Projeto>>.internal(
  projetos,
  name: r'projetosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$projetosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProjetosRef = AutoDisposeFutureProviderRef<List<_Projeto>>;
String _$ordensHash() => r'c578e1afaac8d93c356c781d31fdcaed2754d661';

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

/// See also [ordens].
@ProviderFor(ordens)
const ordensProvider = OrdensFamily();

/// See also [ordens].
class OrdensFamily extends Family<AsyncValue<List<_OS>>> {
  /// See also [ordens].
  const OrdensFamily();

  /// See also [ordens].
  OrdensProvider call(
    String projetoId,
  ) {
    return OrdensProvider(
      projetoId,
    );
  }

  @override
  OrdensProvider getProviderOverride(
    covariant OrdensProvider provider,
  ) {
    return call(
      provider.projetoId,
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
  String? get name => r'ordensProvider';
}

/// See also [ordens].
class OrdensProvider extends AutoDisposeFutureProvider<List<_OS>> {
  /// See also [ordens].
  OrdensProvider(
    String projetoId,
  ) : this._internal(
          (ref) => ordens(
            ref as OrdensRef,
            projetoId,
          ),
          from: ordensProvider,
          name: r'ordensProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ordensHash,
          dependencies: OrdensFamily._dependencies,
          allTransitiveDependencies: OrdensFamily._allTransitiveDependencies,
          projetoId: projetoId,
        );

  OrdensProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projetoId,
  }) : super.internal();

  final String projetoId;

  @override
  Override overrideWith(
    FutureOr<List<_OS>> Function(OrdensRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrdensProvider._internal(
        (ref) => create(ref as OrdensRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projetoId: projetoId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<_OS>> createElement() {
    return _OrdensProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrdensProvider && other.projetoId == projetoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projetoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrdensRef on AutoDisposeFutureProviderRef<List<_OS>> {
  /// The parameter `projetoId` of this provider.
  String get projetoId;
}

class _OrdensProviderElement extends AutoDisposeFutureProviderElement<List<_OS>>
    with OrdensRef {
  _OrdensProviderElement(super.provider);

  @override
  String get projetoId => (origin as OrdensProvider).projetoId;
}

String _$subprojetosHash() => r'35986eb3ca6bc2b9d31ecd34861bd761b0d4927d';

/// See also [subprojetos].
@ProviderFor(subprojetos)
const subprojetosProvider = SubprojetosFamily();

/// See also [subprojetos].
class SubprojetosFamily extends Family<AsyncValue<List<_Subprojeto>>> {
  /// See also [subprojetos].
  const SubprojetosFamily();

  /// See also [subprojetos].
  SubprojetosProvider call(
    String osId,
  ) {
    return SubprojetosProvider(
      osId,
    );
  }

  @override
  SubprojetosProvider getProviderOverride(
    covariant SubprojetosProvider provider,
  ) {
    return call(
      provider.osId,
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
  String? get name => r'subprojetosProvider';
}

/// See also [subprojetos].
class SubprojetosProvider extends AutoDisposeFutureProvider<List<_Subprojeto>> {
  /// See also [subprojetos].
  SubprojetosProvider(
    String osId,
  ) : this._internal(
          (ref) => subprojetos(
            ref as SubprojetosRef,
            osId,
          ),
          from: subprojetosProvider,
          name: r'subprojetosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$subprojetosHash,
          dependencies: SubprojetosFamily._dependencies,
          allTransitiveDependencies:
              SubprojetosFamily._allTransitiveDependencies,
          osId: osId,
        );

  SubprojetosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.osId,
  }) : super.internal();

  final String osId;

  @override
  Override overrideWith(
    FutureOr<List<_Subprojeto>> Function(SubprojetosRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubprojetosProvider._internal(
        (ref) => create(ref as SubprojetosRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        osId: osId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<_Subprojeto>> createElement() {
    return _SubprojetosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubprojetosProvider && other.osId == osId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, osId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubprojetosRef on AutoDisposeFutureProviderRef<List<_Subprojeto>> {
  /// The parameter `osId` of this provider.
  String get osId;
}

class _SubprojetosProviderElement
    extends AutoDisposeFutureProviderElement<List<_Subprojeto>>
    with SubprojetosRef {
  _SubprojetosProviderElement(super.provider);

  @override
  String get osId => (origin as SubprojetosProvider).osId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
