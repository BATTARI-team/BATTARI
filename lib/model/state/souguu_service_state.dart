import 'package:battari/model/dto/rest_souguu_notification.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'souguu_service_state.freezed.dart';

@freezed
class SouguuServiceState with _$SouguuServiceState {
  factory SouguuServiceState({
    /// 遭遇してない場合は0, 遭遇した場合は遭遇した相手
    @Default(0) int souguu,
    RestSouguuNotification? restSouguuNotification,
  }) = _SouguuServiceState;

  @override
  String toString() {
    return 'SouguuServiceState(souguu: $souguu, restSouguuNotification: {${restSouguuNotification?.aiteUserId.toString()}, ${restSouguuNotification?.callStartTime.toString()}, ${restSouguuNotification?.callEndTime.toString()}, ${restSouguuNotification?.callId.toString()}, ${restSouguuNotification?.souguuReason.toString()}, ${restSouguuNotification?.souguuDateTime.toString()}, ${restSouguuNotification?.token.toString()}, ${restSouguuNotification?.aiteUserId.toString()}, ${restSouguuNotification?.aiteUserId.toString()})';
  }
}
