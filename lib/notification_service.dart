import 'package:battari/battari_config.dart';
import 'package:battari/main.dart';
import 'package:battari/profile_view.dart';
import 'package:battari/souguu_service.dart';
import 'package:battari/wait_for_call_notifier_provider.dart';
import 'package:battari/wait_for_call_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_foreground_task/flutter_foreground_task_platform_interface.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class NotificationService {
  int notificationId = 0;
  final ref;

  NotificationService(this.ref);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  Future<void> init() async {
    final androidFlutterLocalNotificationPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidFlutterLocalNotificationPlugin != null) {
      await androidFlutterLocalNotificationPlugin
          .requestNotificationsPermission();
    }
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (id) async {
      debugPrint('Notification received');
      switch (id.payload) {
        case "friend_add":
          Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
              builder: (context) => ProfileView(
                    userId: aiteUserId,
                    userName: aiteUserName,
                    userIconUrl: aiteIconUrl,
                    userDescription: aiteDescription,
                  )));
        case "wait_for_call_view":
          ProviderScope.containerOf(navigatorKey.currentContext!)
              .read(countdownNotifierProvider.notifier)
              .startCountdown(countdown, countdown_max);
          Navigator.of(navigatorKey.currentContext!)
              .push(MaterialPageRoute(builder: (context) => WaitForCall()));
      }
    });
  }

  //Future<void> showSouguuNotification(String userName,
  //    {int countdown = 0}) async {
  //  while (countdown >= 0) {
  //    await Future.delayed(Duration(seconds: 1));
  //    if (countdown == 0) _clearCountdownNotification();
  //    if (countdown < 3) {
  //      _showCountdownNotification(userName, countdown--, true, true);
  //    } else {
  //      _showCountdownNotification(userName, countdown--, false, false);
  //    }
  //  }
  //}

  showCountdownNotification(String userName, int countdown, bool playSound,
      bool enableVibration) async {
    // フォアグラウンドの場合は通知を送信しない
    if ((await FlutterForegroundTask.isAppOnForeground)) return;
    if (countdown == countdown_max) {
      await flutterLocalNotificationsPlugin.show(
        20001,
        "$userNameと遭遇しました",
        "",
        NotificationDetails(
            android: AndroidNotificationDetails('souguu_init', "遭遇通知",
                importance: Importance.max,
                priority: Priority.high,
                playSound: true,
                enableVibration: true)),
      );
    }
    ;
    await flutterLocalNotificationsPlugin.show(
        20000,
        '$userNameと遭遇しました',
        '通話まで$countdown秒',
        NotificationDetails(
            android: AndroidNotificationDetails(
          'souguu',
          '遭遇通知',
          importance: Importance.max,
          priority: Priority.high,
          playSound: false,
          enableVibration: false,
        )),
        payload: 'wait_for_call_view');
  }

  //#BUG なぜか消えない
  clearCountdownNotification() async {
    debugPrint("clearCountdownNotification");
    await flutterLocalNotificationsPlugin.cancel(20000);
  }

  showFriendRequestNotification() async {
    await Future.delayed(Duration(seconds: delay_addfriend_notification));
    await flutterLocalNotificationsPlugin.show(
        0,
        '$aiteUserName さんから友達申請がきました',
        '通知をタップして友達追加を行います',
        payload: 'friend_add',
        NotificationDetails(
            android: AndroidNotificationDetails('friend_add', '友達追加',
                importance: Importance.max,
                priority: Priority.high,
                showWhen: false)));
  }
}

final flutterLocalNotificationsPluginProvider =
    Provider((ref) => NotificationService(ref));
