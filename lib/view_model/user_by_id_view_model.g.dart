// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_by_id_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProviderByIdHash() => r'a7fd61d18e05f9ffcc6a83c7cd00e7fd9fbeb20d';

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

/// See also [userProviderById].
@ProviderFor(userProviderById)
const userProviderByIdProvider = UserProviderByIdFamily();

/// See also [userProviderById].
class UserProviderByIdFamily extends Family<Raw<Future<String>>> {
  /// See also [userProviderById].
  const UserProviderByIdFamily();

  /// See also [userProviderById].
  UserProviderByIdProvider call(
    int id,
  ) {
    return UserProviderByIdProvider(
      id,
    );
  }

  @override
  UserProviderByIdProvider getProviderOverride(
    covariant UserProviderByIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'userProviderByIdProvider';
}

/// See also [userProviderById].
class UserProviderByIdProvider
    extends AutoDisposeProvider<Raw<Future<String>>> {
  /// See also [userProviderById].
  UserProviderByIdProvider(
    int id,
  ) : this._internal(
          (ref) => userProviderById(
            ref as UserProviderByIdRef,
            id,
          ),
          from: userProviderByIdProvider,
          name: r'userProviderByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProviderByIdHash,
          dependencies: UserProviderByIdFamily._dependencies,
          allTransitiveDependencies:
              UserProviderByIdFamily._allTransitiveDependencies,
          id: id,
        );

  UserProviderByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    Raw<Future<String>> Function(UserProviderByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProviderByIdProvider._internal(
        (ref) => create(ref as UserProviderByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Raw<Future<String>>> createElement() {
    return _UserProviderByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProviderByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserProviderByIdRef on AutoDisposeProviderRef<Raw<Future<String>>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _UserProviderByIdProviderElement
    extends AutoDisposeProviderElement<Raw<Future<String>>>
    with UserProviderByIdRef {
  _UserProviderByIdProviderElement(super.provider);

  @override
  int get id => (origin as UserProviderByIdProvider).id;
}

String _$userNameProviderByIdHash() =>
    r'32ba004faae848e2186981bc2963660d2306ad79';

/// See also [userNameProviderById].
@ProviderFor(userNameProviderById)
const userNameProviderByIdProvider = UserNameProviderByIdFamily();

/// See also [userNameProviderById].
class UserNameProviderByIdFamily extends Family<Raw<Future<String>>> {
  /// See also [userNameProviderById].
  const UserNameProviderByIdFamily();

  /// See also [userNameProviderById].
  UserNameProviderByIdProvider call(
    int id,
  ) {
    return UserNameProviderByIdProvider(
      id,
    );
  }

  @override
  UserNameProviderByIdProvider getProviderOverride(
    covariant UserNameProviderByIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'userNameProviderByIdProvider';
}

/// See also [userNameProviderById].
class UserNameProviderByIdProvider
    extends AutoDisposeProvider<Raw<Future<String>>> {
  /// See also [userNameProviderById].
  UserNameProviderByIdProvider(
    int id,
  ) : this._internal(
          (ref) => userNameProviderById(
            ref as UserNameProviderByIdRef,
            id,
          ),
          from: userNameProviderByIdProvider,
          name: r'userNameProviderByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userNameProviderByIdHash,
          dependencies: UserNameProviderByIdFamily._dependencies,
          allTransitiveDependencies:
              UserNameProviderByIdFamily._allTransitiveDependencies,
          id: id,
        );

  UserNameProviderByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    Raw<Future<String>> Function(UserNameProviderByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserNameProviderByIdProvider._internal(
        (ref) => create(ref as UserNameProviderByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Raw<Future<String>>> createElement() {
    return _UserNameProviderByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserNameProviderByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserNameProviderByIdRef on AutoDisposeProviderRef<Raw<Future<String>>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _UserNameProviderByIdProviderElement
    extends AutoDisposeProviderElement<Raw<Future<String>>>
    with UserNameProviderByIdRef {
  _UserNameProviderByIdProviderElement(super.provider);

  @override
  int get id => (origin as UserNameProviderByIdProvider).id;
}

String _$userIdProviderByIdHash() =>
    r'a3ecedba975bb5d5ffc32404a0fcf696699a9cdf';

/// See also [userIdProviderById].
@ProviderFor(userIdProviderById)
const userIdProviderByIdProvider = UserIdProviderByIdFamily();

/// See also [userIdProviderById].
class UserIdProviderByIdFamily extends Family<Raw<Future<String>>> {
  /// See also [userIdProviderById].
  const UserIdProviderByIdFamily();

  /// See also [userIdProviderById].
  UserIdProviderByIdProvider call(
    int id,
  ) {
    return UserIdProviderByIdProvider(
      id,
    );
  }

  @override
  UserIdProviderByIdProvider getProviderOverride(
    covariant UserIdProviderByIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'userIdProviderByIdProvider';
}

/// See also [userIdProviderById].
class UserIdProviderByIdProvider
    extends AutoDisposeProvider<Raw<Future<String>>> {
  /// See also [userIdProviderById].
  UserIdProviderByIdProvider(
    int id,
  ) : this._internal(
          (ref) => userIdProviderById(
            ref as UserIdProviderByIdRef,
            id,
          ),
          from: userIdProviderByIdProvider,
          name: r'userIdProviderByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userIdProviderByIdHash,
          dependencies: UserIdProviderByIdFamily._dependencies,
          allTransitiveDependencies:
              UserIdProviderByIdFamily._allTransitiveDependencies,
          id: id,
        );

  UserIdProviderByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    Raw<Future<String>> Function(UserIdProviderByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserIdProviderByIdProvider._internal(
        (ref) => create(ref as UserIdProviderByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Raw<Future<String>>> createElement() {
    return _UserIdProviderByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserIdProviderByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserIdProviderByIdRef on AutoDisposeProviderRef<Raw<Future<String>>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _UserIdProviderByIdProviderElement
    extends AutoDisposeProviderElement<Raw<Future<String>>>
    with UserIdProviderByIdRef {
  _UserIdProviderByIdProviderElement(super.provider);

  @override
  int get id => (origin as UserIdProviderByIdProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
