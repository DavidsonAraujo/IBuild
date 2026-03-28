// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirmar_apontamento_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dadosTicketHash() => r'1b0dc0256be827c1a5e10f8709a8acd54f0fdf33';

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

/// See also [dadosTicket].
@ProviderFor(dadosTicket)
const dadosTicketProvider = DadosTicketFamily();

/// See also [dadosTicket].
class DadosTicketFamily extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [dadosTicket].
  const DadosTicketFamily();

  /// See also [dadosTicket].
  DadosTicketProvider call(
    String? codigo,
  ) {
    return DadosTicketProvider(
      codigo,
    );
  }

  @override
  DadosTicketProvider getProviderOverride(
    covariant DadosTicketProvider provider,
  ) {
    return call(
      provider.codigo,
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
  String? get name => r'dadosTicketProvider';
}

/// See also [dadosTicket].
class DadosTicketProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>?> {
  /// See also [dadosTicket].
  DadosTicketProvider(
    String? codigo,
  ) : this._internal(
          (ref) => dadosTicket(
            ref as DadosTicketRef,
            codigo,
          ),
          from: dadosTicketProvider,
          name: r'dadosTicketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dadosTicketHash,
          dependencies: DadosTicketFamily._dependencies,
          allTransitiveDependencies:
              DadosTicketFamily._allTransitiveDependencies,
          codigo: codigo,
        );

  DadosTicketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.codigo,
  }) : super.internal();

  final String? codigo;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>?> Function(DadosTicketRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DadosTicketProvider._internal(
        (ref) => create(ref as DadosTicketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        codigo: codigo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>?> createElement() {
    return _DadosTicketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DadosTicketProvider && other.codigo == codigo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, codigo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DadosTicketRef on AutoDisposeFutureProviderRef<Map<String, dynamic>?> {
  /// The parameter `codigo` of this provider.
  String? get codigo;
}

class _DadosTicketProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>?>
    with DadosTicketRef {
  _DadosTicketProviderElement(super.provider);

  @override
  String? get codigo => (origin as DadosTicketProvider).codigo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
