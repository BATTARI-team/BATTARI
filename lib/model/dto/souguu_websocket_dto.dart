import 'package:battari/model/souguu_incredient/souguu_incredient_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'souguu_websocket_dto.g.dart';
part 'souguu_websocket_dto.freezed.dart';

@freezed
class SouguuWebsocketDto with _$SouguuWebsocketDto {
  factory SouguuWebsocketDto({
    required int id,
    required bool isWelcome,
    required List<Map<String, Object>> incredients,
  }) = _SouguuWebsocketDto;

  factory SouguuWebsocketDto.fromJson(Map<String, dynamic> json) =>
      _$SouguuWebsocketDtoFromJson(json);
}
