// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'souguu_websocket_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SouguuWebsocketDto _$SouguuWebsocketDtoFromJson(Map<String, dynamic> json) {
  return _SouguuWebsocketDto.fromJson(json);
}

/// @nodoc
mixin _$SouguuWebsocketDto {
  int get id => throw _privateConstructorUsedError;
  bool get isWelcome => throw _privateConstructorUsedError;
  List<Map<String, Object>> get incredients =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SouguuWebsocketDtoCopyWith<SouguuWebsocketDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SouguuWebsocketDtoCopyWith<$Res> {
  factory $SouguuWebsocketDtoCopyWith(
          SouguuWebsocketDto value, $Res Function(SouguuWebsocketDto) then) =
      _$SouguuWebsocketDtoCopyWithImpl<$Res, SouguuWebsocketDto>;
  @useResult
  $Res call({int id, bool isWelcome, List<Map<String, Object>> incredients});
}

/// @nodoc
class _$SouguuWebsocketDtoCopyWithImpl<$Res, $Val extends SouguuWebsocketDto>
    implements $SouguuWebsocketDtoCopyWith<$Res> {
  _$SouguuWebsocketDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isWelcome = null,
    Object? incredients = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isWelcome: null == isWelcome
          ? _value.isWelcome
          : isWelcome // ignore: cast_nullable_to_non_nullable
              as bool,
      incredients: null == incredients
          ? _value.incredients
          : incredients // ignore: cast_nullable_to_non_nullable
              as List<Map<String, Object>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SouguuWebsocketDtoImplCopyWith<$Res>
    implements $SouguuWebsocketDtoCopyWith<$Res> {
  factory _$$SouguuWebsocketDtoImplCopyWith(_$SouguuWebsocketDtoImpl value,
          $Res Function(_$SouguuWebsocketDtoImpl) then) =
      __$$SouguuWebsocketDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, bool isWelcome, List<Map<String, Object>> incredients});
}

/// @nodoc
class __$$SouguuWebsocketDtoImplCopyWithImpl<$Res>
    extends _$SouguuWebsocketDtoCopyWithImpl<$Res, _$SouguuWebsocketDtoImpl>
    implements _$$SouguuWebsocketDtoImplCopyWith<$Res> {
  __$$SouguuWebsocketDtoImplCopyWithImpl(_$SouguuWebsocketDtoImpl _value,
      $Res Function(_$SouguuWebsocketDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isWelcome = null,
    Object? incredients = null,
  }) {
    return _then(_$SouguuWebsocketDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isWelcome: null == isWelcome
          ? _value.isWelcome
          : isWelcome // ignore: cast_nullable_to_non_nullable
              as bool,
      incredients: null == incredients
          ? _value._incredients
          : incredients // ignore: cast_nullable_to_non_nullable
              as List<Map<String, Object>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SouguuWebsocketDtoImpl implements _SouguuWebsocketDto {
  _$SouguuWebsocketDtoImpl(
      {required this.id,
      required this.isWelcome,
      required final List<Map<String, Object>> incredients})
      : _incredients = incredients;

  factory _$SouguuWebsocketDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SouguuWebsocketDtoImplFromJson(json);

  @override
  final int id;
  @override
  final bool isWelcome;
  final List<Map<String, Object>> _incredients;
  @override
  List<Map<String, Object>> get incredients {
    if (_incredients is EqualUnmodifiableListView) return _incredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incredients);
  }

  @override
  String toString() {
    return 'SouguuWebsocketDto(id: $id, isWelcome: $isWelcome, incredients: $incredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SouguuWebsocketDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isWelcome, isWelcome) ||
                other.isWelcome == isWelcome) &&
            const DeepCollectionEquality()
                .equals(other._incredients, _incredients));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, isWelcome,
      const DeepCollectionEquality().hash(_incredients));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SouguuWebsocketDtoImplCopyWith<_$SouguuWebsocketDtoImpl> get copyWith =>
      __$$SouguuWebsocketDtoImplCopyWithImpl<_$SouguuWebsocketDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SouguuWebsocketDtoImplToJson(
      this,
    );
  }
}

abstract class _SouguuWebsocketDto implements SouguuWebsocketDto {
  factory _SouguuWebsocketDto(
          {required final int id,
          required final bool isWelcome,
          required final List<Map<String, Object>> incredients}) =
      _$SouguuWebsocketDtoImpl;

  factory _SouguuWebsocketDto.fromJson(Map<String, dynamic> json) =
      _$SouguuWebsocketDtoImpl.fromJson;

  @override
  int get id;
  @override
  bool get isWelcome;
  @override
  List<Map<String, Object>> get incredients;
  @override
  @JsonKey(ignore: true)
  _$$SouguuWebsocketDtoImplCopyWith<_$SouguuWebsocketDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
