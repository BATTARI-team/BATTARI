// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_parser.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dealNotificationForForegroundAppHash() =>
    r'b724c05dde64954d3a7c9da9c09ab361f97be9ee';

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

/// See also [dealNotificationForForegroundApp].
@ProviderFor(dealNotificationForForegroundApp)
const dealNotificationForForegroundAppProvider =
    DealNotificationForForegroundAppFamily();

/// See also [dealNotificationForForegroundApp].
class DealNotificationForForegroundAppFamily extends Family<Object?> {
  /// See also [dealNotificationForForegroundApp].
  const DealNotificationForForegroundAppFamily();

  /// See also [dealNotificationForForegroundApp].
  DealNotificationForForegroundAppProvider call(
    String p0,
  ) {
    return DealNotificationForForegroundAppProvider(
      p0,
    );
  }

  @override
  DealNotificationForForegroundAppProvider getProviderOverride(
    covariant DealNotificationForForegroundAppProvider provider,
  ) {
    return call(
      provider.p0,
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
  String? get name => r'dealNotificationForForegroundAppProvider';
}

/// See also [dealNotificationForForegroundApp].
class DealNotificationForForegroundAppProvider
    extends AutoDisposeProvider<Object?> {
  /// See also [dealNotificationForForegroundApp].
  DealNotificationForForegroundAppProvider(
    String p0,
  ) : this._internal(
          (ref) => dealNotificationForForegroundApp(
            ref as DealNotificationForForegroundAppRef,
            p0,
          ),
          from: dealNotificationForForegroundAppProvider,
          name: r'dealNotificationForForegroundAppProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dealNotificationForForegroundAppHash,
          dependencies: DealNotificationForForegroundAppFamily._dependencies,
          allTransitiveDependencies:
              DealNotificationForForegroundAppFamily._allTransitiveDependencies,
          p0: p0,
        );

  DealNotificationForForegroundAppProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.p0,
  }) : super.internal();

  final String p0;

  @override
  Override overrideWith(
    Object? Function(DealNotificationForForegroundAppRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DealNotificationForForegroundAppProvider._internal(
        (ref) => create(ref as DealNotificationForForegroundAppRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        p0: p0,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Object?> createElement() {
    return _DealNotificationForForegroundAppProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DealNotificationForForegroundAppProvider && other.p0 == p0;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, p0.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DealNotificationForForegroundAppRef on AutoDisposeProviderRef<Object?> {
  /// The parameter `p0` of this provider.
  String get p0;
}

class _DealNotificationForForegroundAppProviderElement
    extends AutoDisposeProviderElement<Object?>
    with DealNotificationForForegroundAppRef {
  _DealNotificationForForegroundAppProviderElement(super.provider);

  @override
  String get p0 => (origin as DealNotificationForForegroundAppProvider).p0;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
