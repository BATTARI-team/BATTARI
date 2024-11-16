// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souguu_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$souguuServiceHash() => r'0fc6d9b15cdc5f01e70f745d02cb9264b48a40ef';

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
String _$souguuServiceInfoHash() => r'ceac21ae96e17012947dea09f5962a090374ff70';

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
