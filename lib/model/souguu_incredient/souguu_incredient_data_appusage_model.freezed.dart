// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'souguu_incredient_data_appusage_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SouguuIncredientDataAppUsageModel _$SouguuIncredientDataAppUsageModelFromJson(
    Map<String, dynamic> json) {
  return _SouguuIncredientDataAppUsageModel.fromJson(json);
}

/// @nodoc
mixin _$SouguuIncredientDataAppUsageModel {
  String get appName => throw _privateConstructorUsedError;
  int get useTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SouguuIncredientDataAppUsageModelCopyWith<SouguuIncredientDataAppUsageModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SouguuIncredientDataAppUsageModelCopyWith<$Res> {
  factory $SouguuIncredientDataAppUsageModelCopyWith(
          SouguuIncredientDataAppUsageModel value,
          $Res Function(SouguuIncredientDataAppUsageModel) then) =
      _$SouguuIncredientDataAppUsageModelCopyWithImpl<$Res,
          SouguuIncredientDataAppUsageModel>;
  @useResult
  $Res call({String appName, int useTime});
}

/// @nodoc
class _$SouguuIncredientDataAppUsageModelCopyWithImpl<$Res,
        $Val extends SouguuIncredientDataAppUsageModel>
    implements $SouguuIncredientDataAppUsageModelCopyWith<$Res> {
  _$SouguuIncredientDataAppUsageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appName = null,
    Object? useTime = null,
  }) {
    return _then(_value.copyWith(
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      useTime: null == useTime
          ? _value.useTime
          : useTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SouguuIncredientDataAppUsageModelImplCopyWith<$Res>
    implements $SouguuIncredientDataAppUsageModelCopyWith<$Res> {
  factory _$$SouguuIncredientDataAppUsageModelImplCopyWith(
          _$SouguuIncredientDataAppUsageModelImpl value,
          $Res Function(_$SouguuIncredientDataAppUsageModelImpl) then) =
      __$$SouguuIncredientDataAppUsageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String appName, int useTime});
}

/// @nodoc
class __$$SouguuIncredientDataAppUsageModelImplCopyWithImpl<$Res>
    extends _$SouguuIncredientDataAppUsageModelCopyWithImpl<$Res,
        _$SouguuIncredientDataAppUsageModelImpl>
    implements _$$SouguuIncredientDataAppUsageModelImplCopyWith<$Res> {
  __$$SouguuIncredientDataAppUsageModelImplCopyWithImpl(
      _$SouguuIncredientDataAppUsageModelImpl _value,
      $Res Function(_$SouguuIncredientDataAppUsageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appName = null,
    Object? useTime = null,
  }) {
    return _then(_$SouguuIncredientDataAppUsageModelImpl(
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      useTime: null == useTime
          ? _value.useTime
          : useTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SouguuIncredientDataAppUsageModelImpl
    implements _SouguuIncredientDataAppUsageModel {
  _$SouguuIncredientDataAppUsageModelImpl(
      {required this.appName, required this.useTime});

  factory _$SouguuIncredientDataAppUsageModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SouguuIncredientDataAppUsageModelImplFromJson(json);

  @override
  final String appName;
  @override
  final int useTime;

  @override
  String toString() {
    return 'SouguuIncredientDataAppUsageModel(appName: $appName, useTime: $useTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SouguuIncredientDataAppUsageModelImpl &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.useTime, useTime) || other.useTime == useTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appName, useTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SouguuIncredientDataAppUsageModelImplCopyWith<
          _$SouguuIncredientDataAppUsageModelImpl>
      get copyWith => __$$SouguuIncredientDataAppUsageModelImplCopyWithImpl<
          _$SouguuIncredientDataAppUsageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SouguuIncredientDataAppUsageModelImplToJson(
      this,
    );
  }
}

abstract class _SouguuIncredientDataAppUsageModel
    implements SouguuIncredientDataAppUsageModel {
  factory _SouguuIncredientDataAppUsageModel(
      {required final String appName,
      required final int useTime}) = _$SouguuIncredientDataAppUsageModelImpl;

  factory _SouguuIncredientDataAppUsageModel.fromJson(
          Map<String, dynamic> json) =
      _$SouguuIncredientDataAppUsageModelImpl.fromJson;

  @override
  String get appName;
  @override
  int get useTime;
  @override
  @JsonKey(ignore: true)
  _$$SouguuIncredientDataAppUsageModelImplCopyWith<
          _$SouguuIncredientDataAppUsageModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
