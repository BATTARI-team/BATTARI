import 'package:freezed_annotation/freezed_annotation.dart';

part 'souguu_material_websocket_dto.g.dart';
part 'souguu_material_websocket_dto.freezed.dart';

///WebsocketDtoの中のdataに入る
@freezed
class SouguuMaterialWebsocketDto with _$SouguuMaterialWebsocketDto {
  factory SouguuMaterialWebsocketDto({
    required int id,
    required bool isWelcome,
    required DateTime created,
    required List<Map<String, dynamic>> incredients,
  }) = _SouguuWebsocketDto;

  factory SouguuMaterialWebsocketDto.fromJson(Map<String, dynamic> json) => _$SouguuMaterialWebsocketDtoFromJson(json);
}
