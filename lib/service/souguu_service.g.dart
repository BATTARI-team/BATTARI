// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souguu_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$souguuServiceHash() => r'2d4b9629a26ea8b23a7da68c23bcf2fb5ccf06b8';

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
String _$souguuServiceInfoHash() => r'88938b9ae0102b8816767d519b6ebecd8a90ea90';

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
