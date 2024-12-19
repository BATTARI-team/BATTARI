import 'dart:async';
import 'dart:convert';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/service/notification_service.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart' show FlutterForegroundTask, TaskHandler, TaskStarter;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// The callback function should always be a top-level or static function.
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  // Called when the task is started.
  final _receiverStreamController = StreamController<String>.broadcast();
  final _sendStreamController = StreamController<String>.broadcast();
  late ProviderContainer providerContainer;
  ProviderSubscription? souguuServiceProviderSubscription;
  ProviderSubscription? userViewmodelProviderSubscription;

  int _count = 0;
  static const String incrementCountCommand = 'incrementCount';

  // ignore: unused_element
  void _incrementCount() {
    _count++;

    // Update notification content.
    FlutterForegroundTask.updateService(
      notificationTitle: 'Hello MyTaskHandler :)',
      notificationText: 'count: $_count',
    );

    // Send data to main isolate.
    FlutterForegroundTask.sendDataToMain(_count);
  }

  StreamSubscription<String> addWebsocketReceiver(Function(String) listener) {
    return _receiverStreamController.stream.listen((event) {
      listener(event);
    });
  }

  StreamSubscription<String> addWebsocketSendListener(Function(String) listener) {
    return _sendStreamController.stream.listen((event) {
      listener(event);
    });
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    var shared = await SharedPreferences.getInstance();
    providerContainer = ProviderContainer(overrides: [
      sharedPreferencesProvider.overrideWithValue(shared),
    ]);

    logger.i("battari service started");
    String token = "";
    try {
      await http
          .post(Uri.parse('http://$ipAddress:5050/User/RefreshToken'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, Object>{
                'refreshToken': shared.getString("refresh_token")!,
                'userIndex': shared.getInt('id')!,
              }))
          .then((value) {
        token = value.body;
      });
    } catch (e) {
      logger.e("battari service started error", error: e, stackTrace: StackTrace.current);
    }
    logger.i("foreground_task_service.dart : token is $token");
    Token = token;
    userViewmodelProviderSubscription = providerContainer.listen(userViewModelProvider, (value, next) {});
    providerContainer.read(userViewModelProvider.notifier).init();
    providerContainer.read(userViewModelProvider.notifier).setToken(token);
    souguuServiceProviderSubscription = providerContainer.listen(souguuServiceProvider, (value, next) {});
  }

  // Called by eventAction in [ForegroundTaskOptions].
  // - nothing() : Not use onRepeatEvent callback.
  // - once() : Call onRepeatEvent only once.
  // - repeat(interval) : Call onRepeatEvent at milliseconds interval.
  @override
  void onRepeatEvent(DateTime timestamp) {
    // // Send data to main isolate.
    // final Map<String, dynamic> data = {
    //   "timestampMillis": timestamp.millisecondsSinceEpoch,
    // };
    // FlutterForegroundTask.sendDataToMain(data);
  }

  // Called when the task is destroyed.
  @override
  Future<void> onDestroy(DateTime timestamp) async {
    logger.i("battari service destroyed");
  }

  // Called when data is sent using [FlutterForegroundTask.sendDataToTask].
  @override
  void onReceiveData(Object data) {}

  // Called when the notification button is pressed.
  @override
  void onNotificationButtonPressed(String id) async {
    logger.i("notification button pressed: $id");
  }

  @override
  void onNotificationPressed() {
    logger.i("notification pressed");
  }
}
