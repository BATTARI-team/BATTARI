import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_service_state.freezed.dart';

@freezed
class PermissionServiceState with _$PermissionServiceState {
  const factory PermissionServiceState({
    @Default(false) bool isFloatingPermitted,
    @Default(false) bool isMicPermitted,
    @Default(false) bool isNotificationPermitted,
    @Default(false) bool isLaunchService,
    @Default(false) bool isLocationPermitted,
  }) = _PermissionServiceState;
}
