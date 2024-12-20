import 'package:freezed_annotation/freezed_annotation.dart';

part 'cancel_call_websocket_dto.g.dart';
part 'cancel_call_websocket_dto.freezed.dart';

@freezed
class CancelCallWebsocketDto with _$CancelCallWebsocketDto {
  const factory CancelCallWebsocketDto({
    required String reason,
  }) = _CancelCallWebsocketDto;

  factory CancelCallWebsocketDto.fromJson(Map<String, dynamic> json) => _$CancelCallWebsocketDtoFromJson(json);
}
