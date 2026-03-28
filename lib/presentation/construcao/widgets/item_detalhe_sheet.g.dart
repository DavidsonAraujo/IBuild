// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detalhe_sheet.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemDetalhesHash() => r'a32614d2209afa5129e412e396f446b7e67535b8';

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

/// See also [itemDetalhes].
@ProviderFor(itemDetalhes)
const itemDetalhesProvider = ItemDetalhesFamily();

/// See also [itemDetalhes].
class ItemDetalhesFamily extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [itemDetalhes].
  const ItemDetalhesFamily();

  /// See also [itemDetalhes].
  ItemDetalhesProvider call(
    String itemId,
  ) {
    return ItemDetalhesProvider(
      itemId,
    );
  }

  @override
  ItemDetalhesProvider getProviderOverride(
    covariant ItemDetalhesProvider provider,
  ) {
    return call(
      provider.itemId,
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
  String? get name => r'itemDetalhesProvider';
}

/// See also [itemDetalhes].
class ItemDetalhesProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>?> {
  /// See also [itemDetalhes].
  ItemDetalhesProvider(
    String itemId,
  ) : this._internal(
          (ref) => itemDetalhes(
            ref as ItemDetalhesRef,
            itemId,
          ),
          from: itemDetalhesProvider,
          name: r'itemDetalhesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemDetalhesHash,
          dependencies: ItemDetalhesFamily._dependencies,
          allTransitiveDependencies:
              ItemDetalhesFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  ItemDetalhesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>?> Function(ItemDetalhesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemDetalhesProvider._internal(
        (ref) => create(ref as ItemDetalhesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>?> createElement() {
    return _ItemDetalhesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemDetalhesProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ItemDetalhesRef on AutoDisposeFutureProviderRef<Map<String, dynamic>?> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _ItemDetalhesProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>?>
    with ItemDetalhesRef {
  _ItemDetalhesProviderElement(super.provider);

  @override
  String get itemId => (origin as ItemDetalhesProvider).itemId;
}

String _$eventosDoItemHash() => r'02579e6eb4704d8d1ff64145200211b912bd517a';

/// See also [eventosDoItem].
@ProviderFor(eventosDoItem)
const eventosDoItemProvider = EventosDoItemFamily();

/// See also [eventosDoItem].
class EventosDoItemFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [eventosDoItem].
  const EventosDoItemFamily();

  /// See also [eventosDoItem].
  EventosDoItemProvider call(
    String itemId,
  ) {
    return EventosDoItemProvider(
      itemId,
    );
  }

  @override
  EventosDoItemProvider getProviderOverride(
    covariant EventosDoItemProvider provider,
  ) {
    return call(
      provider.itemId,
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
  String? get name => r'eventosDoItemProvider';
}

/// See also [eventosDoItem].
class EventosDoItemProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [eventosDoItem].
  EventosDoItemProvider(
    String itemId,
  ) : this._internal(
          (ref) => eventosDoItem(
            ref as EventosDoItemRef,
            itemId,
          ),
          from: eventosDoItemProvider,
          name: r'eventosDoItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventosDoItemHash,
          dependencies: EventosDoItemFamily._dependencies,
          allTransitiveDependencies:
              EventosDoItemFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  EventosDoItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(EventosDoItemRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventosDoItemProvider._internal(
        (ref) => create(ref as EventosDoItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _EventosDoItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventosDoItemProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EventosDoItemRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _EventosDoItemProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with EventosDoItemRef {
  _EventosDoItemProviderElement(super.provider);

  @override
  String get itemId => (origin as EventosDoItemProvider).itemId;
}

String _$vinculosDoItemHash() => r'9b4057df74d8b1d20bdd9814c888b0dded436413';

/// See also [vinculosDoItem].
@ProviderFor(vinculosDoItem)
const vinculosDoItemProvider = VinculosDoItemFamily();

/// See also [vinculosDoItem].
class VinculosDoItemFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [vinculosDoItem].
  const VinculosDoItemFamily();

  /// See also [vinculosDoItem].
  VinculosDoItemProvider call(
    String itemId,
  ) {
    return VinculosDoItemProvider(
      itemId,
    );
  }

  @override
  VinculosDoItemProvider getProviderOverride(
    covariant VinculosDoItemProvider provider,
  ) {
    return call(
      provider.itemId,
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
  String? get name => r'vinculosDoItemProvider';
}

/// See also [vinculosDoItem].
class VinculosDoItemProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [vinculosDoItem].
  VinculosDoItemProvider(
    String itemId,
  ) : this._internal(
          (ref) => vinculosDoItem(
            ref as VinculosDoItemRef,
            itemId,
          ),
          from: vinculosDoItemProvider,
          name: r'vinculosDoItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$vinculosDoItemHash,
          dependencies: VinculosDoItemFamily._dependencies,
          allTransitiveDependencies:
              VinculosDoItemFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  VinculosDoItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(VinculosDoItemRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VinculosDoItemProvider._internal(
        (ref) => create(ref as VinculosDoItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _VinculosDoItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VinculosDoItemProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VinculosDoItemRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _VinculosDoItemProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with VinculosDoItemRef {
  _VinculosDoItemProviderElement(super.provider);

  @override
  String get itemId => (origin as VinculosDoItemProvider).itemId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
