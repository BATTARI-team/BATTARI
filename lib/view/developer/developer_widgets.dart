import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeveloperWidgets {
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
}
