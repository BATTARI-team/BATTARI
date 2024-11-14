// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'c56e1706769f31267d745fdf097272506e6be6ab';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeProvider<Raw<Future<SharedPreferences>>>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferencesRef
    = AutoDisposeProviderRef<Raw<Future<SharedPreferences>>>;
String _$userSharedPreferencesRepositoryHash() =>
    r'e3a464b00d6639979dd9d2b10e9d4adfdecdc637';

/// See also [userSharedPreferencesRepository].
@ProviderFor(userSharedPreferencesRepository)
final userSharedPreferencesRepositoryProvider =
    Provider<UserSharedPreferencesRepository>.internal(
  userSharedPreferencesRepository,
  name: r'userSharedPreferencesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userSharedPreferencesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserSharedPreferencesRepositoryRef
    = ProviderRef<UserSharedPreferencesRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
