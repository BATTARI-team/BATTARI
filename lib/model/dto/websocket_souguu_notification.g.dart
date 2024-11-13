// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_souguu_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebsocketSouguuNotificationImpl _$$WebsocketSouguuNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$WebsocketSouguuNotificationImpl(
      callStartTime: DateTime.parse(json['callStartTime'] as String),
      callId: (json['callId'] as num).toInt(),
      callEndTime: DateTime.parse(json['callEndTime'] as String),
      souguuReason: json['souguuReason'] as String,
      token: json['token'] as String,
      souguuDateTime: DateTime.parse(json['souguuDateTime'] as String),
    );

Map<String, dynamic> _$$WebsocketSouguuNotificationImplToJson(
        _$WebsocketSouguuNotificationImpl instance) =>
    <String, dynamic>{
      'callStartTime': instance.callStartTime.toIso8601String(),
      'callId': instance.callId,
      'callEndTime': instance.callEndTime.toIso8601String(),
      'souguuReason': instance.souguuReason,
      'token': instance.token,
      'souguuDateTime': instance.souguuDateTime.toIso8601String(),
    };
