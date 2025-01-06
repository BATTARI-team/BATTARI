import 'dart:convert';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/model/dto/websocket/cancel_call_websocket_dto.dart';
import 'package:battari/view/splash.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_service.g.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) async {
  logger.i("notification tapped from background");
  if (notificationResponse.actionId == "cancel_call") {
    var sharedPref = await SharedPreferences.getInstance();
    var token = sharedPref.getString("token");
    var response = await http.put(Uri.parse('http://$ipAddress:5050/SouguuInfo/CancelCall'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(const CancelCallWebsocketDto(reason: "").toJson()));
    return;
  }
  if (await FlutterForegroundTask.isAppOnForeground) {
    return;
  } else {
    FlutterForegroundTask.launchApp("/foreground_init");
  }
}

@Riverpod(keepAlive: true)
NotificationService notificationServiceProvider(ref) => NotificationService(ref);

class NotificationService {
  late Ref _ref;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationService(Ref ref) {
    logger.i("NotificationService init");
    _ref = ref;
    () async {
      await flutterLocalNotificationsPlugin.initialize(
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        onDidReceiveNotificationResponse: notificationTapBackground,
        const InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        ),
      );
    }();
  }

  void showCounter(int remain, int userId) async {
    debugPrint("show counter $remain");
    var name = await _ref.watch(userNameProviderByIdProvider(userId));
    await flutterLocalNotificationsPlugin.show(
      0,
      '$nameさんと遭遇しました！',
      '遭遇まであと$remain秒',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          actions: [
            AndroidNotificationAction('cancel_call', '拒否'),
          ],
          onlyAlertOnce: true,
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
    if (remain == 0) {
      await flutterLocalNotificationsPlugin.cancel(0);
    }
  }

  void cancelCounter() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  void showCallCancel(CancelCallWebsocketDto dto) async {
    await flutterLocalNotificationsPlugin.show(
        1,
        "通話が中止されました",
        "通話がキャンセルされました",
        const NotificationDetails(
          android: AndroidNotificationDetails('cancel_call', 'cancel_call', importance: Importance.max, priority: Priority.high),
        ));
  }
}

@riverpod
Raw<Future<String>> userNameProviderById(ref, int id) async {
  var result = await http.put(Uri.parse('http://$ipAddress:5050/User/GetUser?userIndex=$id'), headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $Token',
  });
  return jsonDecode(result.body)['name'];
}

@riverpod
Raw<Future<String>> userIdProviderById(ref, int id) async {
  var result = await http.put(Uri.parse('http://$ipAddress:5050/User/GetUser?userIndex=$id'), headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $Token',
  });
  return jsonDecode(result.body)['userId'];
}
