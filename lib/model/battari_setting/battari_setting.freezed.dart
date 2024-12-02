// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battari_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BattariSetting _$BattariSettingFromJson(Map<String, dynamic> json) {
  return _BattariSetting.fromJson(json);
}

/// @nodoc
mixin _$BattariSetting {
  String get appIdAgora => throw _privateConstructorUsedError;
  SentrySetting get sentry => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BattariSettingCopyWith<BattariSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattariSettingCopyWith<$Res> {
  factory $BattariSettingCopyWith(
          BattariSetting value, $Res Function(BattariSetting) then) =
      _$BattariSettingCopyWithImpl<$Res, BattariSetting>;
  @useResult
  $Res call({String appIdAgora, SentrySetting sentry});

  $SentrySettingCopyWith<$Res> get sentry;
}

/// @nodoc
class _$BattariSettingCopyWithImpl<$Res, $Val extends BattariSetting>
    implements $BattariSettingCopyWith<$Res> {
  _$BattariSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appIdAgora = null,
    Object? sentry = null,
  }) {
    return _then(_value.copyWith(
      appIdAgora: null == appIdAgora
          ? _value.appIdAgora
          : appIdAgora // ignore: cast_nullable_to_non_nullable
              as String,
      sentry: null == sentry
          ? _value.sentry
          : sentry // ignore: cast_nullable_to_non_nullable
              as SentrySetting,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SentrySettingCopyWith<$Res> get sentry {
    return $SentrySettingCopyWith<$Res>(_value.sentry, (value) {
      return _then(_value.copyWith(sentry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BattariSettingImplCopyWith<$Res>
    implements $BattariSettingCopyWith<$Res> {
  factory _$$BattariSettingImplCopyWith(_$BattariSettingImpl value,
          $Res Function(_$BattariSettingImpl) then) =
      __$$BattariSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String appIdAgora, SentrySetting sentry});

  @override
  $SentrySettingCopyWith<$Res> get sentry;
}

/// @nodoc
class __$$BattariSettingImplCopyWithImpl<$Res>
    extends _$BattariSettingCopyWithImpl<$Res, _$BattariSettingImpl>
    implements _$$BattariSettingImplCopyWith<$Res> {
  __$$BattariSettingImplCopyWithImpl(
      _$BattariSettingImpl _value, $Res Function(_$BattariSettingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appIdAgora = null,
    Object? sentry = null,
  }) {
    return _then(_$BattariSettingImpl(
      appIdAgora: null == appIdAgora
          ? _value.appIdAgora
          : appIdAgora // ignore: cast_nullable_to_non_nullable
              as String,
      sentry: null == sentry
          ? _value.sentry
          : sentry // ignore: cast_nullable_to_non_nullable
              as SentrySetting,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattariSettingImpl
    with DiagnosticableTreeMixin
    implements _BattariSetting {
  const _$BattariSettingImpl({required this.appIdAgora, required this.sentry});

  factory _$BattariSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattariSettingImplFromJson(json);

  @override
  final String appIdAgora;
  @override
  final SentrySetting sentry;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BattariSetting(appIdAgora: $appIdAgora, sentry: $sentry)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BattariSetting'))
      ..add(DiagnosticsProperty('appIdAgora', appIdAgora))
      ..add(DiagnosticsProperty('sentry', sentry));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattariSettingImpl &&
            (identical(other.appIdAgora, appIdAgora) ||
                other.appIdAgora == appIdAgora) &&
            (identical(other.sentry, sentry) || other.sentry == sentry));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appIdAgora, sentry);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattariSettingImplCopyWith<_$BattariSettingImpl> get copyWith =>
      __$$BattariSettingImplCopyWithImpl<_$BattariSettingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattariSettingImplToJson(
      this,
    );
  }
}

abstract class _BattariSetting implements BattariSetting {
  const factory _BattariSetting(
      {required final String appIdAgora,
      required final SentrySetting sentry}) = _$BattariSettingImpl;

  factory _BattariSetting.fromJson(Map<String, dynamic> json) =
      _$BattariSettingImpl.fromJson;

  @override
  String get appIdAgora;
  @override
  SentrySetting get sentry;
  @override
  @JsonKey(ignore: true)
  _$$BattariSettingImplCopyWith<_$BattariSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
