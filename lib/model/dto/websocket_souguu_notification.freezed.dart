// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_souguu_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WebsocketSouguuNotification _$WebsocketSouguuNotificationFromJson(
    Map<String, dynamic> json) {
  return _WebsocketSouguuNotification.fromJson(json);
}

/// @nodoc
mixin _$WebsocketSouguuNotification {
  DateTime get callStartTime => throw _privateConstructorUsedError;
  int get callId => throw _privateConstructorUsedError;
  DateTime get callEndTime => throw _privateConstructorUsedError;
  String get souguuReason => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  DateTime get souguuDateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebsocketSouguuNotificationCopyWith<WebsocketSouguuNotification>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebsocketSouguuNotificationCopyWith<$Res> {
  factory $WebsocketSouguuNotificationCopyWith(
          WebsocketSouguuNotification value,
          $Res Function(WebsocketSouguuNotification) then) =
      _$WebsocketSouguuNotificationCopyWithImpl<$Res,
          WebsocketSouguuNotification>;
  @useResult
  $Res call(
      {DateTime callStartTime,
      int callId,
      DateTime callEndTime,
      String souguuReason,
      String token,
      DateTime souguuDateTime});
}

/// @nodoc
class _$WebsocketSouguuNotificationCopyWithImpl<$Res,
        $Val extends WebsocketSouguuNotification>
    implements $WebsocketSouguuNotificationCopyWith<$Res> {
  _$WebsocketSouguuNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callStartTime = null,
    Object? callId = null,
    Object? callEndTime = null,
    Object? souguuReason = null,
    Object? token = null,
    Object? souguuDateTime = null,
  }) {
    return _then(_value.copyWith(
      callStartTime: null == callStartTime
          ? _value.callStartTime
          : callStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      callId: null == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as int,
      callEndTime: null == callEndTime
          ? _value.callEndTime
          : callEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      souguuReason: null == souguuReason
          ? _value.souguuReason
          : souguuReason // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      souguuDateTime: null == souguuDateTime
          ? _value.souguuDateTime
          : souguuDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebsocketSouguuNotificationImplCopyWith<$Res>
    implements $WebsocketSouguuNotificationCopyWith<$Res> {
  factory _$$WebsocketSouguuNotificationImplCopyWith(
          _$WebsocketSouguuNotificationImpl value,
          $Res Function(_$WebsocketSouguuNotificationImpl) then) =
      __$$WebsocketSouguuNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime callStartTime,
      int callId,
      DateTime callEndTime,
      String souguuReason,
      String token,
      DateTime souguuDateTime});
}

/// @nodoc
class __$$WebsocketSouguuNotificationImplCopyWithImpl<$Res>
    extends _$WebsocketSouguuNotificationCopyWithImpl<$Res,
        _$WebsocketSouguuNotificationImpl>
    implements _$$WebsocketSouguuNotificationImplCopyWith<$Res> {
  __$$WebsocketSouguuNotificationImplCopyWithImpl(
      _$WebsocketSouguuNotificationImpl _value,
      $Res Function(_$WebsocketSouguuNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callStartTime = null,
    Object? callId = null,
    Object? callEndTime = null,
    Object? souguuReason = null,
    Object? token = null,
    Object? souguuDateTime = null,
  }) {
    return _then(_$WebsocketSouguuNotificationImpl(
      callStartTime: null == callStartTime
          ? _value.callStartTime
          : callStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      callId: null == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as int,
      callEndTime: null == callEndTime
          ? _value.callEndTime
          : callEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      souguuReason: null == souguuReason
          ? _value.souguuReason
          : souguuReason // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      souguuDateTime: null == souguuDateTime
          ? _value.souguuDateTime
          : souguuDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebsocketSouguuNotificationImpl
    implements _WebsocketSouguuNotification {
  const _$WebsocketSouguuNotificationImpl(
      {required this.callStartTime,
      required this.callId,
      required this.callEndTime,
      required this.souguuReason,
      required this.token,
      required this.souguuDateTime});

  factory _$WebsocketSouguuNotificationImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WebsocketSouguuNotificationImplFromJson(json);

  @override
  final DateTime callStartTime;
  @override
  final int callId;
  @override
  final DateTime callEndTime;
  @override
  final String souguuReason;
  @override
  final String token;
  @override
  final DateTime souguuDateTime;

  @override
  String toString() {
    return 'WebsocketSouguuNotification(callStartTime: $callStartTime, callId: $callId, callEndTime: $callEndTime, souguuReason: $souguuReason, token: $token, souguuDateTime: $souguuDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebsocketSouguuNotificationImpl &&
            (identical(other.callStartTime, callStartTime) ||
                other.callStartTime == callStartTime) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callEndTime, callEndTime) ||
                other.callEndTime == callEndTime) &&
            (identical(other.souguuReason, souguuReason) ||
                other.souguuReason == souguuReason) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.souguuDateTime, souguuDateTime) ||
                other.souguuDateTime == souguuDateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, callStartTime, callId,
      callEndTime, souguuReason, token, souguuDateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebsocketSouguuNotificationImplCopyWith<_$WebsocketSouguuNotificationImpl>
      get copyWith => __$$WebsocketSouguuNotificationImplCopyWithImpl<
          _$WebsocketSouguuNotificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebsocketSouguuNotificationImplToJson(
      this,
    );
  }
}

abstract class _WebsocketSouguuNotification
    implements WebsocketSouguuNotification {
  const factory _WebsocketSouguuNotification(
          {required final DateTime callStartTime,
          required final int callId,
          required final DateTime callEndTime,
          required final String souguuReason,
          required final String token,
          required final DateTime souguuDateTime}) =
      _$WebsocketSouguuNotificationImpl;

  factory _WebsocketSouguuNotification.fromJson(Map<String, dynamic> json) =
      _$WebsocketSouguuNotificationImpl.fromJson;

  @override
  DateTime get callStartTime;
  @override
  int get callId;
  @override
  DateTime get callEndTime;
  @override
  String get souguuReason;
  @override
  String get token;
  @override
  DateTime get souguuDateTime;
  @override
  @JsonKey(ignore: true)
  _$$WebsocketSouguuNotificationImplCopyWith<_$WebsocketSouguuNotificationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
