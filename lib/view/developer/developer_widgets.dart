import 'dart:io';

import 'package:battari/constant/app_color.dart';
import 'package:battari/constant/app_size.dart';
import 'package:battari/view/call.dart';
import 'package:battari/view/developer/app_usage_time.dart';
import 'package:battari/view/developer/background.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/view/online_widget.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:battari/view/developer/websocket_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeveloperWidgets extends StatelessWidget {
  const DeveloperWidgets({super.key});

  static loginedUserWidget(BuildContext context) {
    final appSize = AppSize(context); // AppSize インスタンスを作成

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
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: AppColor.ui.darkborder,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.brand.secondary,
                      ),
                      width: appSize.widgetWidth, // インスタンス経由で widgetWidth にアクセス
                      height: 243,
                      child: Center(
                          child: Column(
                        children: [
                          SizedBox(height: 20),
                          Stack(
                            children: [
                              Container(
                                width: appSize.deviceWidth * 0.2,
                                height: appSize.deviceHeight * 0.1,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 0.5,
                                      blurRadius: 8,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                  border: Border.all(color: AppColor.ui.white),
                                  color: AppColor.ui.a,
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        'assets/images/defaultIcon.png'),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 67,
                                left: 60,
                                child: onlineWidget(width: 22, height: 22),
                              ),
                            ],
                          ),
                          SizedBox(height: appSize.deviceHeight * 0.01),
                          Text(
                            data.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: AppColor.text.darkgray),
                          ),
                          Text("@${data.userId}"),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              onlineWidget(
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '誰かと遭遇するかも...!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color: AppColor.text.darkgray),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 20,
                              ),
                              Text(
                                'スマートフォンを使用している',
                                style: TextStyle(fontSize: 11),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 20,
                              ),
                              Text(
                                '位置情報が自宅',
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          )
                        ],
                      )),
                    ),
                  ),
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
                  onPressed: () => ref
                      .read(userSharedPreferencesRepositoryProvider)
                      .clear());
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
            _developerElement("call", Call(), context)
          ],
        ));
  }

  Widget _developerElement(String title, Widget widget, BuildContext context) {
    return TextButton(
        onPressed: (() => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget))),
        child: Text(title));
  }

  Future<void> _requestPermissions() async {
    // Android 13+, you need to allow notification permission to display foreground service notification.
    //
    // iOS: If you need notification, ask for permission.
    final NotificationPermission notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
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
        channelDescription:
            'This notification appears when the foreground service is running.',
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
