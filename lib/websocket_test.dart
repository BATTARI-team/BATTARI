import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketTest extends StatefulWidget {
  const WebSocketTest({super.key});

  @override
  State<WebSocketTest> createState() => _WebSocketTestState();
}

class _WebSocketTestState extends State<WebSocketTest> {
  @override
  Widget build(BuildContext context) {
    final channel = IOWebSocketChannel.connect(Uri.parse('ws://192.168.11.14:5050/ws'), headers: {
      HttpHeaders.authorizationHeader:
          // user tokenを入れる
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJCQVRUQVJJLXRlYW0iLCJuYW1laWQiOiJ0YWt1dG8xMTI3IiwibmFtZSI6InRha3V0bzExMjciLCJqdGkiOiJjOWQ5MjIyYy0wNzI1LTQ3MGEtYWY0Yy0zMWIxYmMwNTcyZTgiLCJ1bmlxdWVfbmFtZSI6IjIiLCJleHAiOjE3MzAwNzI1NDV9.DiYTeemV2MetP0pejg3KcbL1HwI8Jwzn03Zh1w2DeVI'
    });

    TextEditingController _controller = TextEditingController(text: "hello");

    return StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          print(snapshot.hasData ? '${snapshot.data}' : 'No data');
          return Column(
            children: [
              Text(snapshot.hasData ? '${snapshot.data}' : 'No data'),
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
                  channel.sink.add(myJson);
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
        });
  }
}
