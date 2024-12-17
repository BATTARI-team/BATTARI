// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WebsocketDto _$WebsocketDtoFromJson(Map<String, dynamic> json) {
  return _WebsocketDto.fromJson(json);
}

/// @nodoc
mixin _$WebsocketDto {
// 遭遇通知:notification
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebsocketDtoCopyWith<WebsocketDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebsocketDtoCopyWith<$Res> {
  factory $WebsocketDtoCopyWith(
          WebsocketDto value, $Res Function(WebsocketDto) then) =
      _$WebsocketDtoCopyWithImpl<$Res, WebsocketDto>;
  @useResult
  $Res call({String type, Map<String, dynamic> data});
}

/// @nodoc
class _$WebsocketDtoCopyWithImpl<$Res, $Val extends WebsocketDto>
    implements $WebsocketDtoCopyWith<$Res> {
  _$WebsocketDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebsocketDtoImplCopyWith<$Res>
    implements $WebsocketDtoCopyWith<$Res> {
  factory _$$WebsocketDtoImplCopyWith(
          _$WebsocketDtoImpl value, $Res Function(_$WebsocketDtoImpl) then) =
      __$$WebsocketDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, Map<String, dynamic> data});
}

/// @nodoc
class __$$WebsocketDtoImplCopyWithImpl<$Res>
    extends _$WebsocketDtoCopyWithImpl<$Res, _$WebsocketDtoImpl>
    implements _$$WebsocketDtoImplCopyWith<$Res> {
  __$$WebsocketDtoImplCopyWithImpl(
      _$WebsocketDtoImpl _value, $Res Function(_$WebsocketDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
  }) {
    return _then(_$WebsocketDtoImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebsocketDtoImpl implements _WebsocketDto {
  _$WebsocketDtoImpl(
      {required this.type, required final Map<String, dynamic> data})
      : _data = data;

  factory _$WebsocketDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebsocketDtoImplFromJson(json);

// 遭遇通知:notification
  @override
  final String type;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'WebsocketDto(type: $type, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebsocketDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebsocketDtoImplCopyWith<_$WebsocketDtoImpl> get copyWith =>
      __$$WebsocketDtoImplCopyWithImpl<_$WebsocketDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebsocketDtoImplToJson(
      this,
    );
  }
}

abstract class _WebsocketDto implements WebsocketDto {
  factory _WebsocketDto(
      {required final String type,
      required final Map<String, dynamic> data}) = _$WebsocketDtoImpl;

  factory _WebsocketDto.fromJson(Map<String, dynamic> json) =
      _$WebsocketDtoImpl.fromJson;

  @override // 遭遇通知:notification
  String get type;
  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$WebsocketDtoImplCopyWith<_$WebsocketDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
