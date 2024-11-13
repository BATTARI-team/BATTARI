// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_souguu_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebsocketSouguuNotificationImpl _$$WebsocketSouguuNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$WebsocketSouguuNotificationImpl(
      callStartTime: DateTime.parse(json['CallStartTime'] as String),
      callId: (json['CallId'] as num).toInt(),
      callEndTime: DateTime.parse(json['CallEndTime'] as String),
      souguuReason: json['SouguuReason'] as String,
      token: json['Token'] as String,
      souguuDateTime: DateTime.parse(json['SouguuDateTime'] as String),
    );

Map<String, dynamic> _$$WebsocketSouguuNotificationImplToJson(
        _$WebsocketSouguuNotificationImpl instance) =>
    <String, dynamic>{
      'CallStartTime': instance.callStartTime.toIso8601String(),
      'CallId': instance.callId,
      'CallEndTime': instance.callEndTime.toIso8601String(),
      'SouguuReason': instance.souguuReason,
      'Token': instance.token,
      'SouguuDateTime': instance.souguuDateTime.toIso8601String(),
    };
