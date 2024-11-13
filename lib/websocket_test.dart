import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:battari/main.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/service/websocket_service.dart';
import 'package:battari/util/token_util.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketTest extends StatefulWidget {
  const WebSocketTest({super.key});

  @override
  State<WebSocketTest> createState() => _WebSocketTestState();
}

class _WebSocketTestState extends State<WebSocketTest> {
  final listenerKey = "websockettestview";
  @override
  void dispose() {
    debugPrint("websocket test dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: "hello");

    _sendMessage(WidgetRef ref, {String? message}) {
      message ??= jsonEncode({
        'id': 2,
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
      ref.read(websocketServiceProvider).sendMessage(message);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Test'),
      ),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) => Text(ref.watch(souguuServiceProvider).souguu.toString()),
          ),
          Consumer(builder: (context, ref, _) {
            return TextButton(
              child: const Text('Send message'),
              onPressed: () {
                _sendMessage(ref,
                    message: jsonEncode({
                      'id': ref.read(userViewModelProvider).asData?.value?.id,
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
                    }));
              },
            );
          }),
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Send a message'),
          ),
          Consumer(builder: (context, ref, _) {
            return Text("token: ${ref.read(userViewModelProvider).when(data: (data) {
              return data!.token;
            }, loading: () {
              return "";
            }, error: ((error, stackTrace) {
              return "";
            }))}");
          }),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return TextButton(child: Text("connect websocket"), onPressed: () => ref.read(websocketServiceProvider).needConnect());
            },
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return TextButton(child: Text("canncel websocket"), onPressed: () => ref.read(websocketServiceProvider).cancelConnect());
            },
          ),
          Text("受信"),
          HookConsumer(builder: (context, ref, _) {
            var messages = useState([]);
            final websocketService = ref.watch(websocketServiceProvider);

            useEffect(() {
              var subscription = websocketService.addWebsocketReceiver((data) {
                messages.value = [...messages.value, data];
              });
              return () => subscription.cancel();
            }, [websocketService]);

            return Flexible(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Text(messages.value[index]);
                },
                itemCount: messages.value.length,
              ),
            );
          }),
          const Text("送信"),
          HookConsumer(builder: (context, ref, _) {
            var messages = useState([]);

            useEffect(() {
              var stream = ref.read(websocketServiceProvider).addWebsocketSendListener((p0) => messages.value = [...messages.value, p0]);
              return () => stream.cancel();
            }, [websocketService]);

            return Flexible(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Text(messages.value[index]);
                },
                itemCount: messages.value.length,
              ),
            );
          })
        ],
      ),
    );
  }
}
