import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_dto.freezed.dart';
part 'websocket_dto.g.dart';

@freezed
class WebsocketDto with _$WebsocketDto {
  factory WebsocketDto({
    required String type,
    required Map<String, dynamic> data,
  }) = _WebsocketDto;

  factory WebsocketDto.fromJson(Map<String, dynamic> json) => _$WebsocketDtoFromJson(json);
}
