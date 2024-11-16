import 'dart:io';

import 'package:battari/background.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:battari/websocket_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeveloperWidgets extends StatelessWidget {
  const DeveloperWidgets({super.key});

  static loginedUserWidget() {
    return Consumer(
      builder: (context, ref, _) {
        return ref.watch(userViewModelProvider).when(
            error: (error, _) => Center(
                  child: Text(error.toString()),
                ),
            loading: () => const CircularProgressIndicator(
                  color: Colors.red,
                ),
            data: (data) {
              if (data == null) {
                return const CircularProgressIndicator(
                  color: Colors.red,
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("ユーザー: ${data.name}"),
                  Text("ユーザーID: ${data.id}"),
                  Text(
                    "トークン:${data.token}",
                  )
                ],
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("開発用"),
        ),
        body: Column(
          children: [
            _developerElement("websockettest", const WebSocketTest(), context),
            TextButton(
                child: const Text("clear shared preferences"),
                onPressed: () => ProviderContainer().read(userSharedPreferencesRepositoryProvider).clear()),
            // Consumer(
            //   builder: (context, ref, child) {
            //     ref.watch(souguuServiceProvider);
            //     return Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Text(ref.watch(souguuServiceInfoProvider).souguu.toString()),
            //         TextButton(
            //           child: const Text("websocketディスコネクト"),
            //           onPressed: () => ref.read(souguuServiceProvider.notifier).disconnectWebsocket(),
            //         )
            //       ],
            //     );
            //   },
            // ),
            _developerElement("Background", const ExamplePage(), context),
            HookConsumer(builder: (context, ref, _) {
              return TextButton(
                  onPressed: () async {
                    await _requestPermissions();
                    _initService();
                    FlutterForegroundTask.startService(notificationTitle: "battari", notificationText: "notificationText");
                  },
                  child: const Text("foreground task"));
            }),
            TextButton(
              child: const Text("button"),
              onPressed: () {},
            )
          ],
        ));
  }

  Widget _developerElement(String title, Widget widget, BuildContext context) {
    return TextButton(onPressed: (() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget))), child: Text(title));
  }

  Future<void> _requestPermissions() async {
    // Android 13+, you need to allow notification permission to display foreground service notification.
    //
    // iOS: If you need notification, ask for permission.
    final NotificationPermission notificationPermission = await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (Platform.isAndroid) {
      // Android 12+, there are restrictions on starting a foreground service.
      //
      // To restart the service on device reboot or unexpected problem, you need to allow below permission.
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        // This function requires `android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` permission.
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }

      // Use this utility only if you provide services that require long-term survival,
      // such as exact alarm service, healthcare service, or Bluetooth communication.
      //
      // This utility requires the "android.permission.SCHEDULE_EXACT_ALARM" permission.
      // Using this permission may make app distribution difficult due to Google policy.
      if (!await FlutterForegroundTask.canScheduleExactAlarms) {
        // When you call this function, will be gone to the settings page.
        // So you need to explain to the user why set it.
        await FlutterForegroundTask.openAlarmsAndRemindersSettings();
      }
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
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }
}
