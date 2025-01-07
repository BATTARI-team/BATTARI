import 'dart:convert';
import 'dart:io';

import 'package:battari/constant/app_color.dart';
import 'package:battari/constant/app_size.dart';
import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/model/dto/websocket/cancel_call_websocket_dto.dart';
import 'package:battari/view/call.dart';
import 'package:battari/view/developer/app_usage_time.dart';
import 'package:battari/view/developer/background.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/view/online_widget.dart';
import 'package:battari/view/developer/permission_developper_page.dart';
import 'package:battari/view/instruction/setting_home_view.dart';
import 'package:battari/view_model/is_home_view_model.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:battari/view/developer/websocket_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;

class DeveloperWidgets extends StatelessWidget {
  const DeveloperWidgets({super.key});

  static loginedUserWidget() {
    return Consumer(builder: (context, ref, _) {
      var data = ref.watch(userViewModelProvider);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("ユーザー: ${data?.name}"),
          Text("ユーザーID: ${data?.id}"),
          Text(
            "トークン:${data?.token}",
          ),
          Text("home:${data?.houseLatitude},${data?.houseLongitude}"),
          ref.watch(isHomeViewModelProvider).maybeWhen(
              orElse: () => const CircularProgressIndicator(),
              data: (isHome) {
                return Text("isHome: $isHome");
              }),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("開発用"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: () async {
                  var info = await PackageInfo.fromPlatform();
                  return "${info.version}+${info.buildNumber}";
                }(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Text("version: ${snapshot.data}");
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              _developerElement("websockettest", const WebSocketTest(), context),
              Consumer(builder: (context, ref, _) {
                return TextButton(
                    child: const Text("clear shared preferences"),
                    onPressed: () => ref.read(userSharedPreferencesRepositoryProvider).clear());
              }),
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
              TextButton(
                child: const Text("button"),
                onPressed: () {},
              ),
              _developerElement("appusage", AppUsageTime(), context),
              _developerElement("call", Call(), context),
              _developerElement("settings_home", SettingHomeView(), context),
              TextButton(
                child: const Text("""
          send cancel notif"""),
                onPressed: () async {
                  var response = await http.put(Uri.parse('http://$ipAddress:$port/SouguuInfo/CancelCall'),
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer $Token',
                      },
                      body: jsonEncode(const CancelCallWebsocketDto(reason: "").toJson()));
                  logger.d(response.body + response.statusCode.toString());
                  return;
                },
              ),
              _developerElement("permission", const PermissionDevelopperPage(), context),
              loginedUserWidget(),
            ],
          ),
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

  static void initService() {
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
