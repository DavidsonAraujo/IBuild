// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracao_sistema_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$disciplinasHash() => r'61058d54c09e107577870312f904a6d75eab55d9';

/// See also [disciplinas].
@ProviderFor(disciplinas)
final disciplinasProvider =
    AutoDisposeFutureProvider<List<_Disciplina>>.internal(
  disciplinas,
  name: r'disciplinasProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$disciplinasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DisciplinasRef = AutoDisposeFutureProviderRef<List<_Disciplina>>;
String _$fasesHash() => r'2d4a88091d98f3a35d8b114e9a6bf1f7e3d8be7d';

/// See also [fases].
@ProviderFor(fases)
final fasesProvider = AutoDisposeFutureProvider<List<_FaseTemplate>>.internal(
  fases,
  name: r'fasesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fasesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FasesRef = AutoDisposeFutureProviderRef<List<_FaseTemplate>>;
String _$eventosDaFaseHash() => r'ece6b5f3b2308d15655a7af16bee52f4f2c479a5';

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

/// See also [eventosDaFase].
@ProviderFor(eventosDaFase)
const eventosDaFaseProvider = EventosDaFaseFamily();

/// See also [eventosDaFase].
class EventosDaFaseFamily extends Family<AsyncValue<List<_Evento>>> {
  /// See also [eventosDaFase].
  const EventosDaFaseFamily();

  /// See also [eventosDaFase].
  EventosDaFaseProvider call(
    String faseId,
  ) {
    return EventosDaFaseProvider(
      faseId,
    );
  }

  @override
  EventosDaFaseProvider getProviderOverride(
    covariant EventosDaFaseProvider provider,
  ) {
    return call(
      provider.faseId,
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
  String? get name => r'eventosDaFaseProvider';
}

/// See also [eventosDaFase].
class EventosDaFaseProvider extends AutoDisposeFutureProvider<List<_Evento>> {
  /// See also [eventosDaFase].
  EventosDaFaseProvider(
    String faseId,
  ) : this._internal(
          (ref) => eventosDaFase(
            ref as EventosDaFaseRef,
            faseId,
          ),
          from: eventosDaFaseProvider,
          name: r'eventosDaFaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventosDaFaseHash,
          dependencies: EventosDaFaseFamily._dependencies,
          allTransitiveDependencies:
              EventosDaFaseFamily._allTransitiveDependencies,
          faseId: faseId,
        );

  EventosDaFaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.faseId,
  }) : super.internal();

  final String faseId;

  @override
  Override overrideWith(
    FutureOr<List<_Evento>> Function(EventosDaFaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventosDaFaseProvider._internal(
        (ref) => create(ref as EventosDaFaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        faseId: faseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<_Evento>> createElement() {
    return _EventosDaFaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventosDaFaseProvider && other.faseId == faseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, faseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EventosDaFaseRef on AutoDisposeFutureProviderRef<List<_Evento>> {
  /// The parameter `faseId` of this provider.
  String get faseId;
}

class _EventosDaFaseProviderElement
    extends AutoDisposeFutureProviderElement<List<_Evento>>
    with EventosDaFaseRef {
  _EventosDaFaseProviderElement(super.provider);

  @override
  String get faseId => (origin as EventosDaFaseProvider).faseId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
