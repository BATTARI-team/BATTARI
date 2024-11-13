import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_souguu_notification.freezed.dart';
part 'websocket_souguu_notification.g.dart';

@freezed
class WebsocketSouguuNotification with _$WebsocketSouguuNotification {
  const factory WebsocketSouguuNotification({
    required DateTime callStartTime,
    required int callId,
    required DateTime callEndTime,
    required String souguuReason,
    required String token,
    required DateTime souguuDateTime,
  }) = _WebsocketSouguuNotification;

  factory WebsocketSouguuNotification.fromJson(Map<String, dynamic> json) => _$WebsocketSouguuNotificationFromJson(json);
}
