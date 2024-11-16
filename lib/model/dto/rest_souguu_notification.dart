import 'package:freezed_annotation/freezed_annotation.dart';
part 'rest_souguu_notification.freezed.dart';
part 'rest_souguu_notification.g.dart';

@freezed
class RestSouguuNotification with _$RestSouguuNotification {
  const factory RestSouguuNotification({
    // ignore: invalid_annotation_target
    required DateTime callStartTime,
    // ignore: invalid_annotation_target
    required int callId,
    // ignore: invalid_annotation_target
    required DateTime callEndTime,
    // ignore: invalid_annotation_target
    required String souguuReason,
    // ignore: invalid_annotation_target
    required String token,
    // ignore: invalid_annotation_target
    required DateTime souguuDateTime,
    // ignore: invalid_annotation_target
    required int aiteUserId,
  }) = _WebsocketSouguuNotification;

  factory RestSouguuNotification.fromJson(Map<String, dynamic> json) => _$RestSouguuNotificationFromJson(json);
}
