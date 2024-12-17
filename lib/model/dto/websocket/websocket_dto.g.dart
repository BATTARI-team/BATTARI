// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebsocketDtoImpl _$$WebsocketDtoImplFromJson(Map<String, dynamic> json) =>
    _$WebsocketDtoImpl(
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$WebsocketDtoImplToJson(_$WebsocketDtoImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };
