// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cancel_call_websocket_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CancelCallWebsocketDto _$CancelCallWebsocketDtoFromJson(
    Map<String, dynamic> json) {
  return _CancelCallWebsocketDto.fromJson(json);
}

/// @nodoc
mixin _$CancelCallWebsocketDto {
  String get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CancelCallWebsocketDtoCopyWith<CancelCallWebsocketDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CancelCallWebsocketDtoCopyWith<$Res> {
  factory $CancelCallWebsocketDtoCopyWith(CancelCallWebsocketDto value,
          $Res Function(CancelCallWebsocketDto) then) =
      _$CancelCallWebsocketDtoCopyWithImpl<$Res, CancelCallWebsocketDto>;
  @useResult
  $Res call({String reason});
}

/// @nodoc
class _$CancelCallWebsocketDtoCopyWithImpl<$Res,
        $Val extends CancelCallWebsocketDto>
    implements $CancelCallWebsocketDtoCopyWith<$Res> {
  _$CancelCallWebsocketDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CancelCallWebsocketDtoImplCopyWith<$Res>
    implements $CancelCallWebsocketDtoCopyWith<$Res> {
  factory _$$CancelCallWebsocketDtoImplCopyWith(
          _$CancelCallWebsocketDtoImpl value,
          $Res Function(_$CancelCallWebsocketDtoImpl) then) =
      __$$CancelCallWebsocketDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String reason});
}

/// @nodoc
class __$$CancelCallWebsocketDtoImplCopyWithImpl<$Res>
    extends _$CancelCallWebsocketDtoCopyWithImpl<$Res,
        _$CancelCallWebsocketDtoImpl>
    implements _$$CancelCallWebsocketDtoImplCopyWith<$Res> {
  __$$CancelCallWebsocketDtoImplCopyWithImpl(
      _$CancelCallWebsocketDtoImpl _value,
      $Res Function(_$CancelCallWebsocketDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_$CancelCallWebsocketDtoImpl(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CancelCallWebsocketDtoImpl implements _CancelCallWebsocketDto {
  const _$CancelCallWebsocketDtoImpl({required this.reason});

  factory _$CancelCallWebsocketDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CancelCallWebsocketDtoImplFromJson(json);

  @override
  final String reason;

  @override
  String toString() {
    return 'CancelCallWebsocketDto(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelCallWebsocketDtoImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelCallWebsocketDtoImplCopyWith<_$CancelCallWebsocketDtoImpl>
      get copyWith => __$$CancelCallWebsocketDtoImplCopyWithImpl<
          _$CancelCallWebsocketDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CancelCallWebsocketDtoImplToJson(
      this,
    );
  }
}

abstract class _CancelCallWebsocketDto implements CancelCallWebsocketDto {
  const factory _CancelCallWebsocketDto({required final String reason}) =
      _$CancelCallWebsocketDtoImpl;

  factory _CancelCallWebsocketDto.fromJson(Map<String, dynamic> json) =
      _$CancelCallWebsocketDtoImpl.fromJson;

  @override
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$CancelCallWebsocketDtoImplCopyWith<_$CancelCallWebsocketDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
