import 'package:freezed_annotation/freezed_annotation.dart';

part 'sentry_setting.freezed.dart';
part 'sentry_setting.g.dart';

@freezed
class SentrySetting with _$SentrySetting {
  const factory SentrySetting({
    required String dsn,
  }) = _SentrySetting;

  factory SentrySetting.fromJson(Map<String, dynamic> json) => _$SentrySettingFromJson(json);
}
