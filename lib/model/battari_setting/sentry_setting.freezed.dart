// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sentry_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SentrySetting _$SentrySettingFromJson(Map<String, dynamic> json) {
  return _SentrySetting.fromJson(json);
}

/// @nodoc
mixin _$SentrySetting {
  String get dsn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SentrySettingCopyWith<SentrySetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentrySettingCopyWith<$Res> {
  factory $SentrySettingCopyWith(
          SentrySetting value, $Res Function(SentrySetting) then) =
      _$SentrySettingCopyWithImpl<$Res, SentrySetting>;
  @useResult
  $Res call({String dsn});
}

/// @nodoc
class _$SentrySettingCopyWithImpl<$Res, $Val extends SentrySetting>
    implements $SentrySettingCopyWith<$Res> {
  _$SentrySettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dsn = null,
  }) {
    return _then(_value.copyWith(
      dsn: null == dsn
          ? _value.dsn
          : dsn // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentrySettingImplCopyWith<$Res>
    implements $SentrySettingCopyWith<$Res> {
  factory _$$SentrySettingImplCopyWith(
          _$SentrySettingImpl value, $Res Function(_$SentrySettingImpl) then) =
      __$$SentrySettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String dsn});
}

/// @nodoc
class __$$SentrySettingImplCopyWithImpl<$Res>
    extends _$SentrySettingCopyWithImpl<$Res, _$SentrySettingImpl>
    implements _$$SentrySettingImplCopyWith<$Res> {
  __$$SentrySettingImplCopyWithImpl(
      _$SentrySettingImpl _value, $Res Function(_$SentrySettingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dsn = null,
  }) {
    return _then(_$SentrySettingImpl(
      dsn: null == dsn
          ? _value.dsn
          : dsn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SentrySettingImpl implements _SentrySetting {
  const _$SentrySettingImpl({required this.dsn});

  factory _$SentrySettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SentrySettingImplFromJson(json);

  @override
  final String dsn;

  @override
  String toString() {
    return 'SentrySetting(dsn: $dsn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentrySettingImpl &&
            (identical(other.dsn, dsn) || other.dsn == dsn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, dsn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SentrySettingImplCopyWith<_$SentrySettingImpl> get copyWith =>
      __$$SentrySettingImplCopyWithImpl<_$SentrySettingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SentrySettingImplToJson(
      this,
    );
  }
}

abstract class _SentrySetting implements SentrySetting {
  const factory _SentrySetting({required final String dsn}) =
      _$SentrySettingImpl;

  factory _SentrySetting.fromJson(Map<String, dynamic> json) =
      _$SentrySettingImpl.fromJson;

  @override
  String get dsn;
  @override
  @JsonKey(ignore: true)
  _$$SentrySettingImplCopyWith<_$SentrySettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
