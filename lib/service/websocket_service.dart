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

class BattariWebsocketSubscription {
  BattariWebsocketSubscription(this.key, this.listener);
  final int key;
  final Function(String) listener;

  close() {}
}

@riverpod
WebsocketService websocketService(Ref ref) {
  WebsocketService websocketService = WebsocketService(ref);
  ref.onDispose(() async {
    if (websocketService.isRunning) {
      await websocketService.cancelConnect();
    }
  });
  return websocketService;
}

class WebsocketService {
  WebsocketService(this._ref);

  final Ref _ref;
  late Timer _reconnectTimer;
  late IOWebSocketChannel channel;
  bool _isReconnect = false;
  int _count = 0;
  Map<int, Function(String)> listeners = {};
  final receiverStreamController = StreamController<String>.broadcast();
  List<Function(String)> _sendListeners = [];

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

  Future<void> cancelConnect() async {
    _reconnectTimer.cancel();
    await channel.sink.close();
  }

  void sendMessage(String data) {
    _sendWebsocket(data);
  }

  StreamSubscription<String> addWebsocketReceiver(Function(String) listener) {
    return receiverStreamController.stream.listen((event) {
      listener(event);
    });
  }

  void addWebsocketSendListener(Function(String) listener) {
    _sendListeners.add(listener);
  }

  void removeWebsocketReceiver(int key) {}

  void removeWebsocketSendListener(Function(String) listener) {
    _sendListeners.remove(listener);
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
        receiverStreamController.add(event);
        _count = 0;
      }, onError: (error) {
        debugPrint("websocketの接続に失敗しました: $error");
        if (error is SocketException) {
          debugPrint("websocketの接続に失敗しました:");
        }
        _reconnectWebSocket();
      });
      // #TODO 遭遇サービスで定義するべき
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
