import 'package:battari/repository/user_repository.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:battari/websocket_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeveloperWidgets extends StatelessWidget {
  static loginedUserWidget() {
    return Consumer(
      builder: (context, ref, _) {
        return ref.watch(userViewModelProvider).when(
            error: (error, _) => Center(
                  child: Text(error.toString()),
                ),
            loading: () => const CircularProgressIndicator(
                  color: Colors.red,
                ),
            data: (data) {
              if (data == null) {
                return const CircularProgressIndicator(
                  color: Colors.red,
                );
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
        appBar: AppBar(
          title: Text("開発用"),
        ),
        body: Column(
          children: [
            _developerElement("websockettest", const WebSocketTest(), context),
            TextButton(
                child: const Text("clear shared preferences"),
                onPressed: () => ProviderContainer().read(userSharedPreferencesRepositoryProvider).clear()),
            Consumer(
              builder: (context, ref, child) {
                ref.watch(souguuServiceProvider);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(ref.watch(souguuServiceProvider).souguu.toString()),
                    TextButton(
                      child: const Text("websocketディスコネクト"),
                      onPressed: () => ref.read(souguuServiceProvider.notifier).disconnectWebsocket(),
                    )
                  ],
                );
              },
            )
          ],
        ));
  }

  Widget _developerElement(String title, Widget widget, BuildContext context) {
    return TextButton(onPressed: (() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget))), child: Text(title));
  }
}
