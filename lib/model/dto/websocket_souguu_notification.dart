import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_souguu_notification.freezed.dart';
part 'websocket_souguu_notification.g.dart';

@freezed
class WebsocketSouguuNotification with _$WebsocketSouguuNotification {
  const factory WebsocketSouguuNotification({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'CallStartTime') required DateTime callStartTime,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'CallId') required int callId,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'CallEndTime') required DateTime callEndTime,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'SouguuReason') required String souguuReason,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'Token') required String token,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'SouguuDateTime') required DateTime souguuDateTime,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'AiteUserId') required int aiteUserId,
  }) = _WebsocketSouguuNotification;

  factory WebsocketSouguuNotification.fromJson(Map<String, dynamic> json) => _$WebsocketSouguuNotificationFromJson(json);
}
