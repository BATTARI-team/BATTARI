// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battari_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BattariSettingImpl _$$BattariSettingImplFromJson(Map<String, dynamic> json) =>
    _$BattariSettingImpl(
      appIdAgora: json['appIdAgora'] as String,
      sentry: SentrySetting.fromJson(json['sentry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BattariSettingImplToJson(
        _$BattariSettingImpl instance) =>
    <String, dynamic>{
      'appIdAgora': instance.appIdAgora,
      'sentry': instance.sentry,
    };
