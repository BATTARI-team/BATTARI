// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souguu_websocket_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SouguuWebsocketDtoImpl _$$SouguuWebsocketDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$SouguuWebsocketDtoImpl(
      id: (json['id'] as num).toInt(),
      isWelcome: json['isWelcome'] as bool,
      incredients: (json['incredients'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$SouguuWebsocketDtoImplToJson(
        _$SouguuWebsocketDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isWelcome': instance.isWelcome,
      'incredients': instance.incredients,
    };
