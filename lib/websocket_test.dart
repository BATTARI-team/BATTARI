import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketTest extends StatefulWidget {
  const WebSocketTest({super.key});

  @override
  State<WebSocketTest> createState() => _WebSocketTestState();
}

class _WebSocketTestState extends State<WebSocketTest> {
  late IOWebSocketChannel channel;
  bool isReconnect = false;
  late Timer timer;
  late Timer _timer;
  int i = 0;
  bool closeStatus = false;
  reconnectWebSocket() {
    debugPrint("reconnect作業開始 $isReconnect");
    if (isReconnect) return;
    isReconnect = true;
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      // if (timer.tick == 60) {
      // }
      print("現在" + timer.tick.toString());
      try {
        connectWebscocket();
        timer.cancel();
        debugPrint("WebSocket is reconnected");
      } catch (e) {
        print("error" + e.toString());
      }
    });
  }

  connectWebscocket() {
    try {
      channel = IOWebSocketChannel.connect(Uri.parse('ws://192.168.10.4:5050/ws'), headers: {
        HttpHeaders.authorizationHeader:
            // user tokenを入れる
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJCQVRUQVJJLXRlYW0iLCJuYW1laWQiOiJ0YWt1dG8xMTI3IiwibmFtZSI6InRha3V0bzExMjciLCJqdGkiOiJjOWQ5MjIyYy0wNzI1LTQ3MGEtYWY0Yy0zMWIxYmMwNTcyZTgiLCJ1bmlxdWVfbmFtZSI6IjIiLCJleHAiOjE3MzAwNzI1NDV9.DiYTeemV2MetP0pejg3KcbL1HwI8Jwzn03Zh1w2DeVI'
      });
      // channel.stream.listen(
      //   (message) {
      //     // メッセージを受信したときの処理
      //     print("Received: $message");
      //     isReconnect = false;
      //     i = 0;
      //   },
      //   onDone: () {
      //     // 接続が切断されたときの処理
      //     debugPrint("WebSocket is closed");
      //     reconnectWebSocket();
      //   },
      //   onError: (error) {
      //     // エラーが発生したときの処理
      //     print("Error: $error");
      //     reconnectWebSocket();
      //   },
      // );
    } catch (e) {
      print("connectWebscocketでエラー" + e.toString());
    }

    // channel.sink.done.then((value) async {
    //   debugPrint("done");
    // });
  }

  @override
  void initState() {
    super.initState();
    connectWebscocket();
    () async {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) {
        if (i > 3) {
          debugPrint("WebSocket is closed");
          channel.sink.close();
          i = 0;
        }
        i++;
        debugPrint("closeStatus ${channel.closeCode}");
        if (channel.closeCode != null) {
          channel.sink.close();
          reconnectWebSocket();
          i = 0;
        }
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: "hello");

    return Column(
      children: [
        TextButton(
          child: const Text('Send message'),
          onPressed: () {
            //channel.sink.add(_controller.text);
            String myJson = jsonEncode({
              'id': 4,
              'isWelcome': false,
              'incredients': [
                {
                  'type': 'app',
                  'appData': {
                    'appName': 'hakondate',
                    'useTime': 5,
                  }
                },
              ]
            });
            try {
              channel.sink.add(myJson);
            } catch (e) {
              print("sink addでエラー" + e.toString());
            }
          },
        ),
        TextFormField(
          controller: _controller,
          decoration: const InputDecoration(labelText: 'Send a message'),
        ),
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            channel.sink.close();
          },
        ),
      ],
    );
  }
}
