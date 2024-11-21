// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'souguu_incredient_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SouguuIncredientDataModel _$SouguuIncredientDataModelFromJson(
    Map<String, dynamic> json) {
  return _SouguuIncredientDataModel.fromJson(json);
}

/// @nodoc
mixin _$SouguuIncredientDataModel {
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SouguuIncredientDataModelCopyWith<SouguuIncredientDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SouguuIncredientDataModelCopyWith<$Res> {
  factory $SouguuIncredientDataModelCopyWith(SouguuIncredientDataModel value,
          $Res Function(SouguuIncredientDataModel) then) =
      _$SouguuIncredientDataModelCopyWithImpl<$Res, SouguuIncredientDataModel>;
  @useResult
  $Res call({String type});
}

/// @nodoc
class _$SouguuIncredientDataModelCopyWithImpl<$Res,
        $Val extends SouguuIncredientDataModel>
    implements $SouguuIncredientDataModelCopyWith<$Res> {
  _$SouguuIncredientDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SouguuIncredientDataModelImplCopyWith<$Res>
    implements $SouguuIncredientDataModelCopyWith<$Res> {
  factory _$$SouguuIncredientDataModelImplCopyWith(
          _$SouguuIncredientDataModelImpl value,
          $Res Function(_$SouguuIncredientDataModelImpl) then) =
      __$$SouguuIncredientDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type});
}

/// @nodoc
class __$$SouguuIncredientDataModelImplCopyWithImpl<$Res>
    extends _$SouguuIncredientDataModelCopyWithImpl<$Res,
        _$SouguuIncredientDataModelImpl>
    implements _$$SouguuIncredientDataModelImplCopyWith<$Res> {
  __$$SouguuIncredientDataModelImplCopyWithImpl(
      _$SouguuIncredientDataModelImpl _value,
      $Res Function(_$SouguuIncredientDataModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$SouguuIncredientDataModelImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SouguuIncredientDataModelImpl implements _SouguuIncredientDataModel {
  _$SouguuIncredientDataModelImpl({required this.type});

  factory _$SouguuIncredientDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SouguuIncredientDataModelImplFromJson(json);

  @override
  final String type;

  @override
  String toString() {
    return 'SouguuIncredientDataModel(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SouguuIncredientDataModelImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SouguuIncredientDataModelImplCopyWith<_$SouguuIncredientDataModelImpl>
      get copyWith => __$$SouguuIncredientDataModelImplCopyWithImpl<
          _$SouguuIncredientDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SouguuIncredientDataModelImplToJson(
      this,
    );
  }
}

abstract class _SouguuIncredientDataModel implements SouguuIncredientDataModel {
  factory _SouguuIncredientDataModel({required final String type}) =
      _$SouguuIncredientDataModelImpl;

  factory _SouguuIncredientDataModel.fromJson(Map<String, dynamic> json) =
      _$SouguuIncredientDataModelImpl.fromJson;

  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$SouguuIncredientDataModelImplCopyWith<_$SouguuIncredientDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
