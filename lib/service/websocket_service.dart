import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:battari/model/dto/websocket_souguu_notification.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/io.dart';

part 'websocket_service.g.dart';

@Riverpod(keepAlive: true)
WebsocketService websocketService(Ref ref) {
  return WebsocketService(ref);
}

class WebsocketService {
  WebsocketService(this._ref);

  final Ref _ref;
  late Timer _reconnectTimer;
  late IOWebSocketChannel channel;
  bool _isReconnect = false;
  int _count = 0;
  List<Function(String)> _listeners = [];
  List<Function(String)> _sendListeners = [];
  Function(String) _dealNotification = (p0) {
    debugPrint("execute");
    // ここで受信したデータを処理する
    if (p0.length > 20) {
      try {
        var notif = WebsocketSouguuNotification.fromJson(jsonDecode(p0));
        debugPrint("受信したデータ: ${notif.souguuReason}");
      } catch (e) {
        debugPrint("受信したデータ: ${e.toString()}");
      }
    }
  };

  void needConnect() {
    _reconnectTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (_count > 7) {
        _reconnectWebSocket();
        channel.sink.close();
        _count = 0;
      }
      _count++;
    });
    _reconnectWebSocket();
  }

  void cancelConnect() async {
    _reconnectTimer.cancel();
    await channel.sink.close();
  }

  void sendMessage(String data) {
    _sendWebsocket(data);
  }

  void addWebsocketReceiver(Function(String) listener) {
    _listeners.add(listener);
  }

  void addWebsocketSendListener(Function(String) listener) {
    _sendListeners.add(listener);
  }

  bool isRunning = false;

  void _reconnectWebSocket() {
    if (_isReconnect) return;
    _isReconnect = true;
    Timer.periodic(Duration(seconds: 10), (timer) {
      print("現在" + timer.tick.toString());
      try {
        _connectWebsocket();
        timer.cancel();
        debugPrint("WebSocket is reconnected");
      } catch (e) {
        print("error" + e.toString());
      }
    });
    _isReconnect = false;
  }

  _connectWebsocket() async {
    try {
      String? token = "";
      _ref.watch(userViewModelProvider).whenData((value) => token = value?.token);
      debugPrint("token" + token.toString());
      if (token == null) return;

      channel = IOWebSocketChannel.connect(Uri.parse('ws://$IpAddress:5050/ws'), headers: {
        'Authorization':
            // user tokenを入れる
            //'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJCQVRUQVJJLXRlYW0iLCJuYW1laWQiOiJ0YWt1dG8xMTI3IiwibmFtZSI6InRha3V0bzExMjciLCJqdGkiOiJlZTFhMGEzMi1lMTE4LTQyOTMtOTIzNC05MTQ5ODI2NzcwN2MiLCJ1bmlxdWVfbmFtZSI6IjIiLCJleHAiOjE3MzAzMjM5MjR9.D3YpMLMsPd5n4_yjDbACkvuhO-qneSW6fntpvzegGPw'
            'Bearer $token'
      });
      // エラーハンドリングが特殊😭 https://github.com/dart-lang/web_socket_channel/issues/38
      try {
        await channel.ready;
      } catch (e) {
        print("readyでエラー $e");
        _reconnectWebSocket();
      }
      channel.stream.listen((event) {
        _sendWebsocket("hello");
        for (var listener in _listeners) {
          listener(event.toString());
        }
        _count = 0;
      }, onError: (error) {
        debugPrint("websocketの接続に失敗しました: $error");
        if (error is SocketException) {
          debugPrint("websocketの接続に失敗しました:");
        }
        _reconnectWebSocket();
      });
      // #TODO 遭遇サービスで定義するべき
      _listeners.add(_dealNotification);
    } catch (e) {
      print("connectWebsocketでエラー $e");
      if (e is SocketException) {
        _reconnectWebSocket();
      }
    }
  }

  void _sendWebsocket(String message) async {
    try {
      channel.sink.add(message);
    } catch (e) {
      print("sendWebsocketでエラー $e");
    }
    for (var element in _sendListeners) {
      element(message);
    }
  }
}
