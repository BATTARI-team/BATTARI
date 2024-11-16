import 'package:freezed_annotation/freezed_annotation.dart';

part 'souguu_service_state.freezed.dart';

@freezed
class SouguuServiceState with _$SouguuServiceState {
  factory SouguuServiceState({
    /// 遭遇してない場合は0, 遭遇した場合は遭遇した相手
    @Default(0) int souguu,
  }) = _SouguuServiceState;
}
