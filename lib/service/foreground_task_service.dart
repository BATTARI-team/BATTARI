import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:battari/main.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/service/websocket_service.dart';
import 'package:battari/util/token_util.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart' show FlutterForegroundTask, TaskHandler, TaskStarter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

// The callback function should always be a top-level or static function.
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  // Called when the task is started.
  late IOWebSocketChannel channel;
  final _receiverStreamController = StreamController<String>.broadcast();
  final _sendStreamController = StreamController<String>.broadcast();
  late ProviderContainer providerContainer;
  ProviderSubscription? souguuServiceProviderSubscription;
  ProviderSubscription? userViewmodelProviderSubscription;
  Future<void> cancelConnect() async {
    // _reconnectTimer.cancel();
    await channel.sink.close();
  }

  int _count = 0;
  static const String incrementCountCommand = 'incrementCount';

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

  void _sendWebsocket(String message) async {
    try {
      channel.sink.add(message);
      _sendStreamController.add(message);
    } catch (e) {
      print("sendWebsocketでエラー $e");
    }
  }

  void sendMessage(String data) {
    _sendWebsocket(data);
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
    print('onStart(starter: ${starter.name})');
    String token = "";
    await http
        .post(Uri.parse('http://$IpAddress:5050/User/RefreshToken'),
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
    Token = token;
    userViewmodelProviderSubscription = providerContainer.listen(userViewModelProvider, (value, next) {});
    providerContainer.read(userViewModelProvider.notifier).setToken(token);
    souguuServiceProviderSubscription = providerContainer.listen(souguuServiceProvider, (value, next) {});
    // http.get(Uri.parse('http://$IpAddress:5050/Developer/ClearUserOnline')).then((res) {
    //   log(res.body);
    // });
    print("tokenはこちら");
    print(token);
    // channel = IOWebSocketChannel.connect(Uri.parse('ws://$IpAddress:5050/ws'), headers: {
    //   'Authorization':
    //       // user tokenを入れる
    //       //'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJCQVRUQVJJLXRlYW0iLCJuYW1laWQiOiJ0YWt1dG8xMTI3IiwibmFtZSI6InRha3V0bzExMjciLCJqdGkiOiJlZTFhMGEzMi1lMTE4LTQyOTMtOTIzNC05MTQ5ODI2NzcwN2MiLCJ1bmlxdWVfbmFtZSI6IjIiLCJleHAiOjE3MzAzMjM5MjR9.D3YpMLMsPd5n4_yjDbACkvuhO-qneSW6fntpvzegGPw'
    //       'Bearer ${token}'
    // });
    // try {
    //   await channel.ready;
    //   // isRunning = true;
    //   // _isReconnect = false;
    // } catch (e) {
    //   print("readyでエラー $e");
    //   // await _reconnectWebSocket();
    // }
    // channel.stream.listen((event) {
    //   _sendWebsocket("hello");
    //   _receiverStreamController.add(event);
    //   // _count = 0;
    // }, onError: (error) {
    //   debugPrint("websocketの接続に失敗しました: $error");
    //   if (error is SocketException) {
    //     debugPrint("websocketの接続に失敗しました:");
    //   }
    // });
  }

  // Called by eventAction in [ForegroundTaskOptions].
  // - nothing() : Not use onRepeatEvent callback.
  // - once() : Call onRepeatEvent only once.
  // - repeat(interval) : Call onRepeatEvent at milliseconds interval.
  @override
  void onRepeatEvent(DateTime timestamp) {
    // Send data to main isolate.
    final Map<String, dynamic> data = {
      "timestampMillis": timestamp.millisecondsSinceEpoch,
    };
    FlutterForegroundTask.sendDataToMain(data);
  }

  // Called when the task is destroyed.
  @override
  Future<void> onDestroy(DateTime timestamp) async {
    print('onDestroy');
  }

  // Called when data is sent using [FlutterForegroundTask.sendDataToTask].
  @override
  void onReceiveData(Object data) {
    print('onReceiveData: $data');
  }

  // Called when the notification button is pressed.
  @override
  void onNotificationButtonPressed(String id) {
    print('onNotificationButtonPressed: $id');
  }
}
