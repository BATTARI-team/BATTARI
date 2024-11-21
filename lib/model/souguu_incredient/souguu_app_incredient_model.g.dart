// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souguu_app_incredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SouguuAppIncredientModelImpl _$$SouguuAppIncredientModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SouguuAppIncredientModelImpl(
      type: json['type'] as String,
      appData: SouguuIncredientDataAppUsageModel.fromJson(
          json['appData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SouguuAppIncredientModelImplToJson(
        _$SouguuAppIncredientModelImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'appData': instance.appData,
    };
