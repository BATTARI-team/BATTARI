// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souguu_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$souguuServiceHash() => r'4532d327f1679293754d31bafb7e677e15e93ae5';

/// See also [SouguuService].
@ProviderFor(SouguuService)
final souguuServiceProvider =
    AutoDisposeNotifierProvider<SouguuService, int>.internal(
  SouguuService.new,
  name: r'souguuServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$souguuServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SouguuService = AutoDisposeNotifier<int>;
String _$souguuServiceInfoHash() => r'13d607ee38b68d8a15c125c81791e87cc8c77c0e';

/// 遭遇しているかなどの情報を保持するプロバイダー
///
/// Copied from [SouguuServiceInfo].
@ProviderFor(SouguuServiceInfo)
final souguuServiceInfoProvider =
    NotifierProvider<SouguuServiceInfo, SouguuServiceState>.internal(
  SouguuServiceInfo.new,
  name: r'souguuServiceInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$souguuServiceInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SouguuServiceInfo = Notifier<SouguuServiceState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
