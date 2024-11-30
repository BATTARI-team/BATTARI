import 'package:battari/logger.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/view/developer/developer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    FlutterForegroundTask.addTaskDataCallback((data) {
      logger.d("foreground task data: $data");
      if (context.mounted) {
        ref.read(souguuServiceProvider.notifier).dealNotification(data.toString(), true);
      }
      // ref.read(souguuServiceProvider.notifier).disconnectWebsocket();
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          context.push('/developer');
        }),
        child: const Text("developer page"),
      ),
      body: Center(
        child: DeveloperWidgets.loginedUserWidget(),
      ),
    );
  }
}
