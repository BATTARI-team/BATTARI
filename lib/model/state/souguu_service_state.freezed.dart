// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'souguu_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SouguuServiceState {
  /// 遭遇してない場合は0, 遭遇した場合は遭遇した相手
  int get souguu => throw _privateConstructorUsedError;
  RestSouguuNotification? get restSouguuNotification =>
      throw _privateConstructorUsedError;
  String get cancelReason => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SouguuServiceStateCopyWith<SouguuServiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SouguuServiceStateCopyWith<$Res> {
  factory $SouguuServiceStateCopyWith(
          SouguuServiceState value, $Res Function(SouguuServiceState) then) =
      _$SouguuServiceStateCopyWithImpl<$Res, SouguuServiceState>;
  @useResult
  $Res call(
      {int souguu,
      RestSouguuNotification? restSouguuNotification,
      String cancelReason});

  $RestSouguuNotificationCopyWith<$Res>? get restSouguuNotification;
}

/// @nodoc
class _$SouguuServiceStateCopyWithImpl<$Res, $Val extends SouguuServiceState>
    implements $SouguuServiceStateCopyWith<$Res> {
  _$SouguuServiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? souguu = null,
    Object? restSouguuNotification = freezed,
    Object? cancelReason = null,
  }) {
    return _then(_value.copyWith(
      souguu: null == souguu
          ? _value.souguu
          : souguu // ignore: cast_nullable_to_non_nullable
              as int,
      restSouguuNotification: freezed == restSouguuNotification
          ? _value.restSouguuNotification
          : restSouguuNotification // ignore: cast_nullable_to_non_nullable
              as RestSouguuNotification?,
      cancelReason: null == cancelReason
          ? _value.cancelReason
          : cancelReason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RestSouguuNotificationCopyWith<$Res>? get restSouguuNotification {
    if (_value.restSouguuNotification == null) {
      return null;
    }

    return $RestSouguuNotificationCopyWith<$Res>(_value.restSouguuNotification!,
        (value) {
      return _then(_value.copyWith(restSouguuNotification: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SouguuServiceStateImplCopyWith<$Res>
    implements $SouguuServiceStateCopyWith<$Res> {
  factory _$$SouguuServiceStateImplCopyWith(_$SouguuServiceStateImpl value,
          $Res Function(_$SouguuServiceStateImpl) then) =
      __$$SouguuServiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int souguu,
      RestSouguuNotification? restSouguuNotification,
      String cancelReason});

  @override
  $RestSouguuNotificationCopyWith<$Res>? get restSouguuNotification;
}

/// @nodoc
class __$$SouguuServiceStateImplCopyWithImpl<$Res>
    extends _$SouguuServiceStateCopyWithImpl<$Res, _$SouguuServiceStateImpl>
    implements _$$SouguuServiceStateImplCopyWith<$Res> {
  __$$SouguuServiceStateImplCopyWithImpl(_$SouguuServiceStateImpl _value,
      $Res Function(_$SouguuServiceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? souguu = null,
    Object? restSouguuNotification = freezed,
    Object? cancelReason = null,
  }) {
    return _then(_$SouguuServiceStateImpl(
      souguu: null == souguu
          ? _value.souguu
          : souguu // ignore: cast_nullable_to_non_nullable
              as int,
      restSouguuNotification: freezed == restSouguuNotification
          ? _value.restSouguuNotification
          : restSouguuNotification // ignore: cast_nullable_to_non_nullable
              as RestSouguuNotification?,
      cancelReason: null == cancelReason
          ? _value.cancelReason
          : cancelReason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SouguuServiceStateImpl implements _SouguuServiceState {
  _$SouguuServiceStateImpl(
      {this.souguu = 0, this.restSouguuNotification, this.cancelReason = ""});

  /// 遭遇してない場合は0, 遭遇した場合は遭遇した相手
  @override
  @JsonKey()
  final int souguu;
  @override
  final RestSouguuNotification? restSouguuNotification;
  @override
  @JsonKey()
  final String cancelReason;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SouguuServiceStateImpl &&
            (identical(other.souguu, souguu) || other.souguu == souguu) &&
            (identical(other.restSouguuNotification, restSouguuNotification) ||
                other.restSouguuNotification == restSouguuNotification) &&
            (identical(other.cancelReason, cancelReason) ||
                other.cancelReason == cancelReason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, souguu, restSouguuNotification, cancelReason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SouguuServiceStateImplCopyWith<_$SouguuServiceStateImpl> get copyWith =>
      __$$SouguuServiceStateImplCopyWithImpl<_$SouguuServiceStateImpl>(
          this, _$identity);
}

abstract class _SouguuServiceState implements SouguuServiceState {
  factory _SouguuServiceState(
      {final int souguu,
      final RestSouguuNotification? restSouguuNotification,
      final String cancelReason}) = _$SouguuServiceStateImpl;

  @override

  /// 遭遇してない場合は0, 遭遇した場合は遭遇した相手
  int get souguu;
  @override
  RestSouguuNotification? get restSouguuNotification;
  @override
  String get cancelReason;
  @override
  @JsonKey(ignore: true)
  _$$SouguuServiceStateImplCopyWith<_$SouguuServiceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
