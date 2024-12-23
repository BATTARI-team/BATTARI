// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souguu_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$souguuServiceHash() => r'c4b3cea9755b05343414682b019f69142f89d7f5';

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
String _$souguuServiceInfoHash() => r'7227f40e51a6ab9337645f09381e5e1a709939d6';

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
