import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod/riverpod.dart';

int num = 0;

class BackgroundService {
  BackgroundService() {
    FlutterForegroundTask.init(
        androidNotificationOptions: AndroidNotificationOptions(
          channelId: 'battari',
          channelName: 'battari',
        ),
        iosNotificationOptions: const IOSNotificationOptions(),
        foregroundTaskOptions: const ForegroundTaskOptions(
          interval: 1000,
          isOnceEvent: false,
          autoRunOnBoot: true,
        ));
    FlutterForegroundTask.startService(
      notificationTitle: "battari",
      notificationText: "battari service running",
      callback: startCallback,
    );
  }
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(BattariTaskHandler());
}

class BattariTaskHandler extends TaskHandler {
  // #TODO 遭遇処理，通知を出すところまでここでやる websocketもここ
  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    FlutterForegroundTask.updateService(notificationText: (num++).toString());
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) {
    debugPrint("destroy");
  }

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) {
    debugPrint("start");
  }
}

final backgroundServiceProvider = Provider((ref) => BackgroundService());
