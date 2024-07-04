import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
    );
  }

  void _initForegroundTask() {
		FlutterForegroundTask.init(
			androidNotificationOptions: AndroidNotificationOptions(channelId: 'foregroundService', channelName: 'battari'), 
			iosNotificationOptions: const IOSNotificationOptions(showNotification:true, playSound:true), 
			foregroundTaskOptions: const ForegroundTaskOptions(
				// タスクを実行する間隔？
				interval: 5000,
				isOnceEvent: false,
				// スマホ起動時に自動実行する？
				autoRunOnBoot: true,
			),
		);
	}
}
