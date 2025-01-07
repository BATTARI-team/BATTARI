import 'dart:io';

import 'package:battari/logger.dart';
import 'package:battari/model/state/permission_service_state.dart';
import 'package:battari/service/foreground_task_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_foreground_task/models/notification_permission.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_service.g.dart';

@Riverpod()
class PermissionService extends _$PermissionService {
  @override
  PermissionServiceState build() {
    return const PermissionServiceState();
  }

  Future<void> init() async {
    logger.d('permission init');
    await requestCallPermission();

    state = state.copyWith(
      isFloatingPermitted: await requestBackgroundServicePermission(),
      isNotificationPermitted: await requestNotificationPermissions(),
      isMicPermitted: await requestMicPermission(),
      isLaunchService: await requestLaunchForegroundService(),
      isLocationPermitted: await requestLocationPermission(),
    );
  }

  Future<bool> requestNotificationPermissions() async {
    final NotificationPermission notificationPermission = await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      var status = await FlutterForegroundTask.requestNotificationPermission();
      var stat = await Permission.notification.request();
      if (status == NotificationPermission.granted) {
        state = state.copyWith(isNotificationPermitted: true);
        return true;
      }
    } else {
      state = state.copyWith(isNotificationPermitted: true);
      return true;
    }
    return false;
  }

  Future<bool> requestBackgroundServicePermission() async {
    bool isOpenSystemAlertWindowSettingsPermitted = false;
    bool isIgnoringBatteryOptimizationsPermitted = false;
    bool isScheduleExactAlarmsPermitted = false;
    // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
    // onNotificationPressed function to be called.
    //
    // When the notification is pressed while permission is denied,
    // the onNotificationPressed function is not called and the app opens.
    //
    // If you do not use the onNotificationPressed or launchApp function,
    // you do not need to write this code.
    if (!await FlutterForegroundTask.canDrawOverlays) {
      // This function requires `android.permission.SYSTEM_ALERT_WINDOW` permission.
      isOpenSystemAlertWindowSettingsPermitted = await FlutterForegroundTask.openSystemAlertWindowSettings();
    }

    // Android 12+, there are restrictions on starting a foreground service.
    //
    // To restart the service on device reboot or unexpected problem, you need to allow below permission.
    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      // This function requires `android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` permission.
      isIgnoringBatteryOptimizationsPermitted = await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }

    // Use this utility only if you provide services that require long-term survival,
    // such as exact alarm service, healthcare service, or Bluetooth communication.
    //
    // This utility requires the "android.permission.SCHEDULE_EXACT_ALARM" permission.
    // Using this permission may make app distribution difficult due to Google policy.
    if (!await FlutterForegroundTask.canScheduleExactAlarms) {
      // When you call this function, will be gone to the settings page.
      // So you need to explain to the user why set it.
      isScheduleExactAlarmsPermitted = await FlutterForegroundTask.openAlarmsAndRemindersSettings();
    }
    return isOpenSystemAlertWindowSettingsPermitted && isIgnoringBatteryOptimizationsPermitted && isScheduleExactAlarmsPermitted;
  }

  Future<bool> requestMicPermission() async {
    var mic = await Permission.microphone.request();
    if (mic.isGranted) {
      state = state.copyWith(isMicPermitted: true);
      return true;
    }
    return false;
  }

  Future<bool> requestCallPermission() async {
    var call = await Permission.phone.request();
    if (call.isGranted) {
      return true;
    }
    return false;
  }

  Future<bool> requestLocationPermission() async {
    var location = await Permission.location.request();
    LocationPermission permission = await GeolocatorPlatform.instance.checkPermission();
    if (permission == LocationPermission.always) {
      return true;
    } else {
      var status = await Permission.locationAlways.request();
      if (status.isGranted) {
        return true;
      }
    }
    return false;
  }

  Future<bool> requestLaunchForegroundService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return true;
    } else {
      var ser = await _startService();
      return ser.success;
    }
  }

  void _initService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription: 'This notification appears when the foreground service is running.',
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        // 自動設定は難しいので一旦切る
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<ServiceRequestResult> _startService() async {
    _initService();
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: 'BATTARI service is running',
        notificationText: '',
        notificationIcon: null,
        notificationButtons: [
          const NotificationButton(id: 'restart', text: '再起動'),
          const NotificationButton(id: 'btn_hello', text: '停止'),
        ],
        callback: startCallback,
      );
    }
  }
}
