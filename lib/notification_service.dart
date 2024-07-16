import 'package:battari/main.dart';
import 'package:battari/profile_view.dart';
import 'package:battari/wait_for_call_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod/riverpod.dart';

class NotificationService {
  int notificationId = 0;

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
                    userId: 'takutakutaku',
                    userName: 'たくと ',
                    userIconUrl:
                        'https://avatars.githubusercontent.com/u/44548782?v=4',
                    userDescription: 'userDescription',
                  )));
        case "wait_for_call_view":
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
    await flutterLocalNotificationsPlugin.show(
        20000,
        '$userNameと遭遇しました',
        '通話まで$countdown秒',
        NotificationDetails(
            android: AndroidNotificationDetails('souguu', '遭遇通知',
                importance: Importance.max,
                priority: Priority.high,
                showWhen: false,
                playSound: playSound,
                enableVibration: enableVibration)),
        payload: 'wait_for_call_view');
  }

  //#BUG なぜか消えない
  clearCountdownNotification() async {
    debugPrint("clearCountdownNotification");
    await flutterLocalNotificationsPlugin.cancel(20000);
  }
}

final flutterLocalNotificationsPluginProvider =
    Provider((ref) => NotificationService());
