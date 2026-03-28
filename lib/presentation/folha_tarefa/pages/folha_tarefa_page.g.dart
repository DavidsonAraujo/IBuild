// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folha_tarefa_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$folhasTarefaHash() => r'aad4fb7a310cb71e85899feb0b6c6423e307f40b';

/// See also [folhasTarefa].
@ProviderFor(folhasTarefa)
final folhasTarefaProvider = AutoDisposeFutureProvider<List<_FT>>.internal(
  folhasTarefa,
  name: r'folhasTarefaProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$folhasTarefaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FolhasTarefaRef = AutoDisposeFutureProviderRef<List<_FT>>;
String _$itensFTHash() => r'a110cac6cf75ba1843c3906cb58ffe4ef824c41d';

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

/// See also [itensFT].
@ProviderFor(itensFT)
const itensFTProvider = ItensFTFamily();

/// See also [itensFT].
class ItensFTFamily extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [itensFT].
  const ItensFTFamily();

  /// See also [itensFT].
  ItensFTProvider call(
    String ftId,
  ) {
    return ItensFTProvider(
      ftId,
    );
  }

  @override
  ItensFTProvider getProviderOverride(
    covariant ItensFTProvider provider,
  ) {
    return call(
      provider.ftId,
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
  String? get name => r'itensFTProvider';
}

/// See also [itensFT].
class ItensFTProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [itensFT].
  ItensFTProvider(
    String ftId,
  ) : this._internal(
          (ref) => itensFT(
            ref as ItensFTRef,
            ftId,
          ),
          from: itensFTProvider,
          name: r'itensFTProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itensFTHash,
          dependencies: ItensFTFamily._dependencies,
          allTransitiveDependencies: ItensFTFamily._allTransitiveDependencies,
          ftId: ftId,
        );

  ItensFTProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ftId,
  }) : super.internal();

  final String ftId;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(ItensFTRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItensFTProvider._internal(
        (ref) => create(ref as ItensFTRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ftId: ftId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _ItensFTProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItensFTProvider && other.ftId == ftId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ftId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ItensFTRef on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `ftId` of this provider.
  String get ftId;
}

class _ItensFTProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with ItensFTRef {
  _ItensFTProviderElement(super.provider);

  @override
  String get ftId => (origin as ItensFTProvider).ftId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
