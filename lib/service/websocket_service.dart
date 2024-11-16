import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:battari/main.dart';
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
  log("websocketService build");
  ref.onDispose(() async {
    if (websocketService.isRunning) {
      await websocketService.cancelConnect();
    }
  });
  websocketService.needConnect();
  return websocketService;
}

class WebsocketService {
  WebsocketService(this._ref);

  // ignore: unused_field
  final Ref _ref;
  Timer? _reconnectTimer;
  IOWebSocketChannel? channel;
  bool _isReconnect = false;
  int _count = 0;
  Map<int, Function(String)> listeners = {};
  final _receiverStreamController = StreamController<String>.broadcast();
  final _sendStreamController = StreamController<String>.broadcast();

  void _initializeTimer() {
    //#TODO asyncにしちゃったから，ロック的なのが必要かも
    _reconnectTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      debugPrint("timer ");
      debugPrint(_count.toString());
      if (_count > 3) {
        await _reset();
        await _reconnectWebSocket();
      }
      _count++;
    });
  }

  void needConnect() async {
    await _reconnectWebSocket();
    _initializeTimer();
  }

  _reset() async {
    _count = 0;
    _isReconnect = false;
    await cancelConnect();
  }

  Future<void> cancelConnect() async {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    await channel?.sink.close(null, "canceled");
    channel = null;
    isRunning = false;
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

  bool isRunning = false;

  _reconnectWebSocket() async {
    debugPrint("reconnect");
    debugPrint("isRunning$isRunning");
    debugPrint("_isReconnect$_isReconnect");
    if (_isReconnect) return;
    if (isRunning) return;
    if (_reconnectTimer == null) {
      _initializeTimer();
    }
    try {
      if (isRunning || _isReconnect) {
        return;
      }
      _isReconnect = true;
      await _connectWebsocket();
      debugPrint("WebSocket is reconnected");
    } catch (e) {
      print("error" + e.toString());
    }
    _isReconnect = false;
  }

  _connectWebsocket() async {
    try {
      String? token = "";
      token = Token;
      // _ref.watch(userViewModelProvider).whenData((value) => token = value?.token);
      debugPrint("token" + token.toString());

      channel = IOWebSocketChannel.connect(Uri.parse('ws://$ipAddress:5050/ws'), headers: {
        'Authorization':
            // user tokenを入れる
            //'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJCQVRUQVJJLXRlYW0iLCJuYW1laWQiOiJ0YWt1dG8xMTI3IiwibmFtZSI6InRha3V0bzExMjciLCJqdGkiOiJlZTFhMGEzMi1lMTE4LTQyOTMtOTIzNC05MTQ5ODI2NzcwN2MiLCJ1bmlxdWVfbmFtZSI6IjIiLCJleHAiOjE3MzAzMjM5MjR9.D3YpMLMsPd5n4_yjDbACkvuhO-qneSW6fntpvzegGPw'
            'Bearer $token'
      });
      // エラーハンドリングが特殊😭 https://github.com/dart-lang/web_socket_channel/issues/38
      try {
        await channel?.ready;
        isRunning = true;
        _isReconnect = false;
        debugPrint("素晴らしいね");
      } catch (e) {
        print("readyでエラー $e");
        await _reconnectWebSocket();
      }
      channel?.stream.listen((event) {
        _sendWebsocket("hello");
        _receiverStreamController.add(event);
        print(event);
        _count = 0;
      }, onError: (error) {
        debugPrint("websocketの接続に失敗しました: $error");
        if (error is SocketException) {
          debugPrint("websocketの接続に失敗しました:");
        }
        isRunning = false;
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
      channel?.sink.add(message);
      _sendStreamController.add(message);
    } catch (e) {
      print("sendWebsocketでエラー $e");
    }
  }
}
