import 'package:freezed_annotation/freezed_annotation.dart';

part 'souguu_notification_between_app_and_service_dto.g.dart';
part 'souguu_notification_between_app_and_service_dto.freezed.dart';

@freezed
class SouguuNotificationBetweenAppAndServiceDto with _$SouguuNotificationBetweenAppAndServiceDto {
  const factory SouguuNotificationBetweenAppAndServiceDto({
    required Map<String, dynamic> websocketDto,
    required String token,
  }) = _SouguuNotificationBetweenAppAndServiceDto;

  factory SouguuNotificationBetweenAppAndServiceDto.fromJson(Map<String, dynamic> json) =>
      _$SouguuNotificationBetweenAppAndServiceDtoFromJson(json);
}
