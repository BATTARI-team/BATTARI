import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class Background extends StatefulWidget {
  const Background({super.key});

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
	int num = 0;
	bool taskLock = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
			child: Text(num.toString(),),
    );
  }
	@override
	void initState() {
		super.initState();
		_initForegroundTask();
		FlutterForegroundTask.startService(notificationTitle: "battari", notificationText: "battari text");
		runTask();
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
	
	Future<void> runTask() async {
		taskLock = true;
		while(taskLock) {
			await Future.delayed(const Duration(seconds: 1));
			setState(() {
				num++;
				FlutterForegroundTask.updateService(notificationText: "battari text: $num");
			});
		}
		taskLock = false;
	}
}
