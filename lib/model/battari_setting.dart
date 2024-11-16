// ignore_for_file: unused_import

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'battari_setting.g.dart';
part 'battari_setting.freezed.dart';

@freezed
class BattariSetting with _$BattariSetting {
  const factory BattariSetting({required String appIdAgora}) = _BattariSetting;

  factory BattariSetting.fromJson(Map<String, dynamic> json) => _$BattariSettingFromJson(json);
}
