// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'souguu_app_incredient_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SouguuAppIncredientModel _$SouguuAppIncredientModelFromJson(
    Map<String, dynamic> json) {
  return _SouguuAppIncredientModel.fromJson(json);
}

/// @nodoc
mixin _$SouguuAppIncredientModel {
  String get type => throw _privateConstructorUsedError;
  SouguuIncredientDataAppUsageModel get appData =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SouguuAppIncredientModelCopyWith<SouguuAppIncredientModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SouguuAppIncredientModelCopyWith<$Res> {
  factory $SouguuAppIncredientModelCopyWith(SouguuAppIncredientModel value,
          $Res Function(SouguuAppIncredientModel) then) =
      _$SouguuAppIncredientModelCopyWithImpl<$Res, SouguuAppIncredientModel>;
  @useResult
  $Res call({String type, SouguuIncredientDataAppUsageModel appData});

  $SouguuIncredientDataAppUsageModelCopyWith<$Res> get appData;
}

/// @nodoc
class _$SouguuAppIncredientModelCopyWithImpl<$Res,
        $Val extends SouguuAppIncredientModel>
    implements $SouguuAppIncredientModelCopyWith<$Res> {
  _$SouguuAppIncredientModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? appData = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      appData: null == appData
          ? _value.appData
          : appData // ignore: cast_nullable_to_non_nullable
              as SouguuIncredientDataAppUsageModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SouguuIncredientDataAppUsageModelCopyWith<$Res> get appData {
    return $SouguuIncredientDataAppUsageModelCopyWith<$Res>(_value.appData,
        (value) {
      return _then(_value.copyWith(appData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SouguuAppIncredientModelImplCopyWith<$Res>
    implements $SouguuAppIncredientModelCopyWith<$Res> {
  factory _$$SouguuAppIncredientModelImplCopyWith(
          _$SouguuAppIncredientModelImpl value,
          $Res Function(_$SouguuAppIncredientModelImpl) then) =
      __$$SouguuAppIncredientModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, SouguuIncredientDataAppUsageModel appData});

  @override
  $SouguuIncredientDataAppUsageModelCopyWith<$Res> get appData;
}

/// @nodoc
class __$$SouguuAppIncredientModelImplCopyWithImpl<$Res>
    extends _$SouguuAppIncredientModelCopyWithImpl<$Res,
        _$SouguuAppIncredientModelImpl>
    implements _$$SouguuAppIncredientModelImplCopyWith<$Res> {
  __$$SouguuAppIncredientModelImplCopyWithImpl(
      _$SouguuAppIncredientModelImpl _value,
      $Res Function(_$SouguuAppIncredientModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? appData = null,
  }) {
    return _then(_$SouguuAppIncredientModelImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      appData: null == appData
          ? _value.appData
          : appData // ignore: cast_nullable_to_non_nullable
              as SouguuIncredientDataAppUsageModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SouguuAppIncredientModelImpl implements _SouguuAppIncredientModel {
  _$SouguuAppIncredientModelImpl({required this.type, required this.appData});

  factory _$SouguuAppIncredientModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SouguuAppIncredientModelImplFromJson(json);

  @override
  final String type;
  @override
  final SouguuIncredientDataAppUsageModel appData;

  @override
  String toString() {
    return 'SouguuAppIncredientModel(type: $type, appData: $appData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SouguuAppIncredientModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.appData, appData) || other.appData == appData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, appData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SouguuAppIncredientModelImplCopyWith<_$SouguuAppIncredientModelImpl>
      get copyWith => __$$SouguuAppIncredientModelImplCopyWithImpl<
          _$SouguuAppIncredientModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SouguuAppIncredientModelImplToJson(
      this,
    );
  }
}

abstract class _SouguuAppIncredientModel implements SouguuAppIncredientModel {
  factory _SouguuAppIncredientModel(
          {required final String type,
          required final SouguuIncredientDataAppUsageModel appData}) =
      _$SouguuAppIncredientModelImpl;

  factory _SouguuAppIncredientModel.fromJson(Map<String, dynamic> json) =
      _$SouguuAppIncredientModelImpl.fromJson;

  @override
  String get type;
  @override
  SouguuIncredientDataAppUsageModel get appData;
  @override
  @JsonKey(ignore: true)
  _$$SouguuAppIncredientModelImplCopyWith<_$SouguuAppIncredientModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
