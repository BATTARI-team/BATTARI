import 'package:freezed_annotation/freezed_annotation.dart';

part 'souguu_notification_dto.g.dart';
part 'souguu_notification_dto.freezed.dart';

@freezed
class SouguuNotificationDto with _$SouguuNotificationDto {
  // WebsocketDtoを入れる
  // dataにはwebsocketSouguuNotificationが入っている
  const factory SouguuNotificationDto({
    required Map<String, dynamic> websocketDto,
    required String token,
  }) = _SouguuNotificationDto;

  factory SouguuNotificationDto.fromJson(Map<String, dynamic> json) => _$SouguuNotificationDtoFromJson(json);
}
