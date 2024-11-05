// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserFormState {
  dynamic get BattariId => throw _privateConstructorUsedError;
  dynamic get Password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserFormStateCopyWith<UserFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFormStateCopyWith<$Res> {
  factory $UserFormStateCopyWith(
          UserFormState value, $Res Function(UserFormState) then) =
      _$UserFormStateCopyWithImpl<$Res, UserFormState>;
  @useResult
  $Res call({dynamic BattariId, dynamic Password});
}

/// @nodoc
class _$UserFormStateCopyWithImpl<$Res, $Val extends UserFormState>
    implements $UserFormStateCopyWith<$Res> {
  _$UserFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? BattariId = freezed,
    Object? Password = freezed,
  }) {
    return _then(_value.copyWith(
      BattariId: freezed == BattariId
          ? _value.BattariId
          : BattariId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Password: freezed == Password
          ? _value.Password
          : Password // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserFormStateImplCopyWith<$Res>
    implements $UserFormStateCopyWith<$Res> {
  factory _$$UserFormStateImplCopyWith(
          _$UserFormStateImpl value, $Res Function(_$UserFormStateImpl) then) =
      __$$UserFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic BattariId, dynamic Password});
}

/// @nodoc
class __$$UserFormStateImplCopyWithImpl<$Res>
    extends _$UserFormStateCopyWithImpl<$Res, _$UserFormStateImpl>
    implements _$$UserFormStateImplCopyWith<$Res> {
  __$$UserFormStateImplCopyWithImpl(
      _$UserFormStateImpl _value, $Res Function(_$UserFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? BattariId = freezed,
    Object? Password = freezed,
  }) {
    return _then(_$UserFormStateImpl(
      BattariId: freezed == BattariId ? _value.BattariId! : BattariId,
      Password: freezed == Password ? _value.Password! : Password,
    ));
  }
}

/// @nodoc

class _$UserFormStateImpl implements _UserFormState {
  const _$UserFormStateImpl({this.BattariId = "", this.Password = ""});

  @override
  @JsonKey()
  final dynamic BattariId;
  @override
  @JsonKey()
  final dynamic Password;

  @override
  String toString() {
    return 'UserFormState(BattariId: $BattariId, Password: $Password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserFormStateImpl &&
            const DeepCollectionEquality().equals(other.BattariId, BattariId) &&
            const DeepCollectionEquality().equals(other.Password, Password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(BattariId),
      const DeepCollectionEquality().hash(Password));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserFormStateImplCopyWith<_$UserFormStateImpl> get copyWith =>
      __$$UserFormStateImplCopyWithImpl<_$UserFormStateImpl>(this, _$identity);
}

abstract class _UserFormState implements UserFormState {
  const factory _UserFormState(
      {final dynamic BattariId, final dynamic Password}) = _$UserFormStateImpl;

  @override
  dynamic get BattariId;
  @override
  dynamic get Password;
  @override
  @JsonKey(ignore: true)
  _$$UserFormStateImplCopyWith<_$UserFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
