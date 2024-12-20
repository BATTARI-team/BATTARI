import 'dart:convert';

import 'package:battari/service/souguu_service.dart';
import 'package:battari/service/websocket_service.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    TextEditingController controller = TextEditingController(text: "hello");

    sendMessage(WidgetRef ref, {String? message}) {
      message ??= jsonEncode({
        'id': ref.read(userViewModelProvider)?.id,
        'isWelcome': false,
        'created': DateTime.now(),
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
            builder: (context, ref, child) => Text(ref.watch(souguuServiceInfoProvider).souguu.toString()),
          ),
          Consumer(builder: (context, ref, _) {
            return TextButton(
              child: const Text('Send message'),
              onPressed: () {
                sendMessage(ref,
                    message: jsonEncode({
                      'id': ref.read(userViewModelProvider)?.id,
                      'isWelcome': false,
                      'created': DateTime.now().toIso8601String(),
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
            controller: controller,
            decoration: const InputDecoration(labelText: 'Send a message'),
          ),
          Consumer(builder: (context, ref, _) {
            return Text("token: ${ref.read(userViewModelProvider) ?? "null"}");
          }),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return TextButton(child: const Text("connect websocket"), onPressed: () => ref.read(websocketServiceProvider).needConnect());
            },
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return TextButton(
                  child: const Text("canncel websocket"), onPressed: () => ref.read(websocketServiceProvider).cancelConnect());
            },
          ),
          const Text("受信"),
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
