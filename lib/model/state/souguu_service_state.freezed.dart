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
  $Res call({int souguu});
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
  }) {
    return _then(_value.copyWith(
      souguu: null == souguu
          ? _value.souguu
          : souguu // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
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
  $Res call({int souguu});
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
  }) {
    return _then(_$SouguuServiceStateImpl(
      souguu: null == souguu
          ? _value.souguu
          : souguu // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SouguuServiceStateImpl implements _SouguuServiceState {
  _$SouguuServiceStateImpl({this.souguu = 0});

  /// 遭遇してない場合は0, 遭遇した場合は遭遇した相手
  @override
  @JsonKey()
  final int souguu;

  @override
  String toString() {
    return 'SouguuServiceState(souguu: $souguu)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SouguuServiceStateImpl &&
            (identical(other.souguu, souguu) || other.souguu == souguu));
  }

  @override
  int get hashCode => Object.hash(runtimeType, souguu);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SouguuServiceStateImplCopyWith<_$SouguuServiceStateImpl> get copyWith =>
      __$$SouguuServiceStateImplCopyWithImpl<_$SouguuServiceStateImpl>(
          this, _$identity);
}

abstract class _SouguuServiceState implements SouguuServiceState {
  factory _SouguuServiceState({final int souguu}) = _$SouguuServiceStateImpl;

  @override

  /// 遭遇してない場合は0, 遭遇した場合は遭遇した相手
  int get souguu;
  @override
  @JsonKey(ignore: true)
  _$$SouguuServiceStateImplCopyWith<_$SouguuServiceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
