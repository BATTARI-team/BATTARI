// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PermissionServiceState {
  bool get isFloatingPermitted => throw _privateConstructorUsedError;
  bool get isMicPermitted => throw _privateConstructorUsedError;
  bool get isNotificationPermitted => throw _privateConstructorUsedError;
  bool get isLaunchService => throw _privateConstructorUsedError;
  bool get isLocationPermitted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PermissionServiceStateCopyWith<PermissionServiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionServiceStateCopyWith<$Res> {
  factory $PermissionServiceStateCopyWith(PermissionServiceState value,
          $Res Function(PermissionServiceState) then) =
      _$PermissionServiceStateCopyWithImpl<$Res, PermissionServiceState>;
  @useResult
  $Res call(
      {bool isFloatingPermitted,
      bool isMicPermitted,
      bool isNotificationPermitted,
      bool isLaunchService,
      bool isLocationPermitted});
}

/// @nodoc
class _$PermissionServiceStateCopyWithImpl<$Res,
        $Val extends PermissionServiceState>
    implements $PermissionServiceStateCopyWith<$Res> {
  _$PermissionServiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFloatingPermitted = null,
    Object? isMicPermitted = null,
    Object? isNotificationPermitted = null,
    Object? isLaunchService = null,
    Object? isLocationPermitted = null,
  }) {
    return _then(_value.copyWith(
      isFloatingPermitted: null == isFloatingPermitted
          ? _value.isFloatingPermitted
          : isFloatingPermitted // ignore: cast_nullable_to_non_nullable
              as bool,
      isMicPermitted: null == isMicPermitted
          ? _value.isMicPermitted
          : isMicPermitted // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotificationPermitted: null == isNotificationPermitted
          ? _value.isNotificationPermitted
          : isNotificationPermitted // ignore: cast_nullable_to_non_nullable
              as bool,
      isLaunchService: null == isLaunchService
          ? _value.isLaunchService
          : isLaunchService // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationPermitted: null == isLocationPermitted
          ? _value.isLocationPermitted
          : isLocationPermitted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PermissionServiceStateImplCopyWith<$Res>
    implements $PermissionServiceStateCopyWith<$Res> {
  factory _$$PermissionServiceStateImplCopyWith(
          _$PermissionServiceStateImpl value,
          $Res Function(_$PermissionServiceStateImpl) then) =
      __$$PermissionServiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isFloatingPermitted,
      bool isMicPermitted,
      bool isNotificationPermitted,
      bool isLaunchService,
      bool isLocationPermitted});
}

/// @nodoc
class __$$PermissionServiceStateImplCopyWithImpl<$Res>
    extends _$PermissionServiceStateCopyWithImpl<$Res,
        _$PermissionServiceStateImpl>
    implements _$$PermissionServiceStateImplCopyWith<$Res> {
  __$$PermissionServiceStateImplCopyWithImpl(
      _$PermissionServiceStateImpl _value,
      $Res Function(_$PermissionServiceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFloatingPermitted = null,
    Object? isMicPermitted = null,
    Object? isNotificationPermitted = null,
    Object? isLaunchService = null,
    Object? isLocationPermitted = null,
  }) {
    return _then(_$PermissionServiceStateImpl(
      isFloatingPermitted: null == isFloatingPermitted
          ? _value.isFloatingPermitted
          : isFloatingPermitted // ignore: cast_nullable_to_non_nullable
              as bool,
      isMicPermitted: null == isMicPermitted
          ? _value.isMicPermitted
          : isMicPermitted // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotificationPermitted: null == isNotificationPermitted
          ? _value.isNotificationPermitted
          : isNotificationPermitted // ignore: cast_nullable_to_non_nullable
              as bool,
      isLaunchService: null == isLaunchService
          ? _value.isLaunchService
          : isLaunchService // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationPermitted: null == isLocationPermitted
          ? _value.isLocationPermitted
          : isLocationPermitted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PermissionServiceStateImpl implements _PermissionServiceState {
  const _$PermissionServiceStateImpl(
      {this.isFloatingPermitted = false,
      this.isMicPermitted = false,
      this.isNotificationPermitted = false,
      this.isLaunchService = false,
      this.isLocationPermitted = false});

  @override
  @JsonKey()
  final bool isFloatingPermitted;
  @override
  @JsonKey()
  final bool isMicPermitted;
  @override
  @JsonKey()
  final bool isNotificationPermitted;
  @override
  @JsonKey()
  final bool isLaunchService;
  @override
  @JsonKey()
  final bool isLocationPermitted;

  @override
  String toString() {
    return 'PermissionServiceState(isFloatingPermitted: $isFloatingPermitted, isMicPermitted: $isMicPermitted, isNotificationPermitted: $isNotificationPermitted, isLaunchService: $isLaunchService, isLocationPermitted: $isLocationPermitted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionServiceStateImpl &&
            (identical(other.isFloatingPermitted, isFloatingPermitted) ||
                other.isFloatingPermitted == isFloatingPermitted) &&
            (identical(other.isMicPermitted, isMicPermitted) ||
                other.isMicPermitted == isMicPermitted) &&
            (identical(
                    other.isNotificationPermitted, isNotificationPermitted) ||
                other.isNotificationPermitted == isNotificationPermitted) &&
            (identical(other.isLaunchService, isLaunchService) ||
                other.isLaunchService == isLaunchService) &&
            (identical(other.isLocationPermitted, isLocationPermitted) ||
                other.isLocationPermitted == isLocationPermitted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isFloatingPermitted,
      isMicPermitted,
      isNotificationPermitted,
      isLaunchService,
      isLocationPermitted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionServiceStateImplCopyWith<_$PermissionServiceStateImpl>
      get copyWith => __$$PermissionServiceStateImplCopyWithImpl<
          _$PermissionServiceStateImpl>(this, _$identity);
}

abstract class _PermissionServiceState implements PermissionServiceState {
  const factory _PermissionServiceState(
      {final bool isFloatingPermitted,
      final bool isMicPermitted,
      final bool isNotificationPermitted,
      final bool isLaunchService,
      final bool isLocationPermitted}) = _$PermissionServiceStateImpl;

  @override
  bool get isFloatingPermitted;
  @override
  bool get isMicPermitted;
  @override
  bool get isNotificationPermitted;
  @override
  bool get isLaunchService;
  @override
  bool get isLocationPermitted;
  @override
  @JsonKey(ignore: true)
  _$$PermissionServiceStateImplCopyWith<_$PermissionServiceStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
