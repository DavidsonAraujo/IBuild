// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suprimentos_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rmasHash() => r'dd2e75e1a60c7aba3a01c08076e16e19b815cdff';

/// See also [rmas].
@ProviderFor(rmas)
final rmasProvider = AutoDisposeFutureProvider<List<_RMA>>.internal(
  rmas,
  name: r'rmasProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$rmasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RmasRef = AutoDisposeFutureProviderRef<List<_RMA>>;
String _$itensRmaHash() => r'09f53a9ae592f8383f5e6f25215a27edeb843731';

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

/// See also [itensRma].
@ProviderFor(itensRma)
const itensRmaProvider = ItensRmaFamily();

/// See also [itensRma].
class ItensRmaFamily extends Family<AsyncValue<List<_ItemRMA>>> {
  /// See also [itensRma].
  const ItensRmaFamily();

  /// See also [itensRma].
  ItensRmaProvider call(
    String rmaId,
  ) {
    return ItensRmaProvider(
      rmaId,
    );
  }

  @override
  ItensRmaProvider getProviderOverride(
    covariant ItensRmaProvider provider,
  ) {
    return call(
      provider.rmaId,
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
  String? get name => r'itensRmaProvider';
}

/// See also [itensRma].
class ItensRmaProvider extends AutoDisposeFutureProvider<List<_ItemRMA>> {
  /// See also [itensRma].
  ItensRmaProvider(
    String rmaId,
  ) : this._internal(
          (ref) => itensRma(
            ref as ItensRmaRef,
            rmaId,
          ),
          from: itensRmaProvider,
          name: r'itensRmaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itensRmaHash,
          dependencies: ItensRmaFamily._dependencies,
          allTransitiveDependencies: ItensRmaFamily._allTransitiveDependencies,
          rmaId: rmaId,
        );

  ItensRmaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.rmaId,
  }) : super.internal();

  final String rmaId;

  @override
  Override overrideWith(
    FutureOr<List<_ItemRMA>> Function(ItensRmaRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItensRmaProvider._internal(
        (ref) => create(ref as ItensRmaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        rmaId: rmaId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<_ItemRMA>> createElement() {
    return _ItensRmaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItensRmaProvider && other.rmaId == rmaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, rmaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ItensRmaRef on AutoDisposeFutureProviderRef<List<_ItemRMA>> {
  /// The parameter `rmaId` of this provider.
  String get rmaId;
}

class _ItensRmaProviderElement
    extends AutoDisposeFutureProviderElement<List<_ItemRMA>> with ItensRmaRef {
  _ItensRmaProviderElement(super.provider);

  @override
  String get rmaId => (origin as ItensRmaProvider).rmaId;
}

String _$materiaisHash() => r'd74903ac328c449dfbb5d4b04e621365f8b37cfe';

/// See also [materiais].
@ProviderFor(materiais)
final materiaisProvider = AutoDisposeFutureProvider<List<_Material>>.internal(
  materiais,
  name: r'materiaisProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$materiaisHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MateriaisRef = AutoDisposeFutureProviderRef<List<_Material>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
