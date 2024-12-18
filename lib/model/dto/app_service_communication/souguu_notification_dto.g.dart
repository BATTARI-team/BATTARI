// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souguu_notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SouguuNotificationDtoImpl _$$SouguuNotificationDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$SouguuNotificationDtoImpl(
      websocketDto: json['websocketDto'] as Map<String, dynamic>,
      token: json['token'] as String,
    );

Map<String, dynamic> _$$SouguuNotificationDtoImplToJson(
        _$SouguuNotificationDtoImpl instance) =>
    <String, dynamic>{
      'websocketDto': instance.websocketDto,
      'token': instance.token,
    };
