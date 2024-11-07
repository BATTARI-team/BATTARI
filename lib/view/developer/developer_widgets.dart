import 'package:battari/view_model/user_view_model.dart';
import 'package:battari/websocket_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeveloperWidgets extends StatelessWidget {
  static loginedUserWidget() {
    return Consumer(
      builder: (context, ref, _) {
        return ref.watch(userViewModelProvider).maybeWhen(
            orElse: () => const CircularProgressIndicator(),
            data: (data) {
              if (data == null) {
                return const CircularProgressIndicator();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("ユーザー: ${data.name}"),
                  Text("ユーザーID: ${data.id}"),
                  Text(
                    "トークン:${data.token}",
                  )
                ],
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WebSocketTest()));
          },
          child: const Text("websockettest"),
        )
      ],
    ));
  }
}
