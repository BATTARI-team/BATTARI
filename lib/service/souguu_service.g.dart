// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souguu_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$souguuServiceHash() => r'c9ff5dba08840a001918b996bd4f01b4d9901152';

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
String _$souguuServiceInfoHash() => r'a23f4f2619ea1fb5567a4ab215330340989b4c22';

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
