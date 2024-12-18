// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'souguu_notification_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SouguuNotificationDto _$SouguuNotificationDtoFromJson(
    Map<String, dynamic> json) {
  return _SouguuNotificationDto.fromJson(json);
}

/// @nodoc
mixin _$SouguuNotificationDto {
  Map<String, dynamic> get websocketDto => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SouguuNotificationDtoCopyWith<SouguuNotificationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SouguuNotificationDtoCopyWith<$Res> {
  factory $SouguuNotificationDtoCopyWith(SouguuNotificationDto value,
          $Res Function(SouguuNotificationDto) then) =
      _$SouguuNotificationDtoCopyWithImpl<$Res, SouguuNotificationDto>;
  @useResult
  $Res call({Map<String, dynamic> websocketDto, String token});
}

/// @nodoc
class _$SouguuNotificationDtoCopyWithImpl<$Res,
        $Val extends SouguuNotificationDto>
    implements $SouguuNotificationDtoCopyWith<$Res> {
  _$SouguuNotificationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websocketDto = null,
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      websocketDto: null == websocketDto
          ? _value.websocketDto
          : websocketDto // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SouguuNotificationDtoImplCopyWith<$Res>
    implements $SouguuNotificationDtoCopyWith<$Res> {
  factory _$$SouguuNotificationDtoImplCopyWith(
          _$SouguuNotificationDtoImpl value,
          $Res Function(_$SouguuNotificationDtoImpl) then) =
      __$$SouguuNotificationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> websocketDto, String token});
}

/// @nodoc
class __$$SouguuNotificationDtoImplCopyWithImpl<$Res>
    extends _$SouguuNotificationDtoCopyWithImpl<$Res,
        _$SouguuNotificationDtoImpl>
    implements _$$SouguuNotificationDtoImplCopyWith<$Res> {
  __$$SouguuNotificationDtoImplCopyWithImpl(_$SouguuNotificationDtoImpl _value,
      $Res Function(_$SouguuNotificationDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websocketDto = null,
    Object? token = null,
  }) {
    return _then(_$SouguuNotificationDtoImpl(
      websocketDto: null == websocketDto
          ? _value._websocketDto
          : websocketDto // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SouguuNotificationDtoImpl implements _SouguuNotificationDto {
  const _$SouguuNotificationDtoImpl(
      {required final Map<String, dynamic> websocketDto, required this.token})
      : _websocketDto = websocketDto;

  factory _$SouguuNotificationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SouguuNotificationDtoImplFromJson(json);

  final Map<String, dynamic> _websocketDto;
  @override
  Map<String, dynamic> get websocketDto {
    if (_websocketDto is EqualUnmodifiableMapView) return _websocketDto;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_websocketDto);
  }

  @override
  final String token;

  @override
  String toString() {
    return 'SouguuNotificationDto(websocketDto: $websocketDto, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SouguuNotificationDtoImpl &&
            const DeepCollectionEquality()
                .equals(other._websocketDto, _websocketDto) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_websocketDto), token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SouguuNotificationDtoImplCopyWith<_$SouguuNotificationDtoImpl>
      get copyWith => __$$SouguuNotificationDtoImplCopyWithImpl<
          _$SouguuNotificationDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SouguuNotificationDtoImplToJson(
      this,
    );
  }
}

abstract class _SouguuNotificationDto implements SouguuNotificationDto {
  const factory _SouguuNotificationDto(
      {required final Map<String, dynamic> websocketDto,
      required final String token}) = _$SouguuNotificationDtoImpl;

  factory _SouguuNotificationDto.fromJson(Map<String, dynamic> json) =
      _$SouguuNotificationDtoImpl.fromJson;

  @override
  Map<String, dynamic> get websocketDto;
  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$SouguuNotificationDtoImplCopyWith<_$SouguuNotificationDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
