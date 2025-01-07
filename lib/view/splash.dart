// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/model/state/user_state.dart';
import 'package:battari/service/foreground_task_service.dart';
import 'package:battari/service/permission_service.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/view/developer/developer_widgets.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usage_stats/usage_stats.dart';

class Splash extends HookConsumerWidget {
  final bool isSouguu;
  const Splash({super.key, required this.isSouguu});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("Splash build");
    var initializationFuture = init(context, ref);
    return FutureBuilder(
        future: initializationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }

  Future<void> init(BuildContext context, WidgetRef ref) async {
    var transaction = Sentry.startTransaction("Splash.init", "Splash.init");
    await ref.read(permissionServiceProvider.notifier).init();
    var sharedPreferences = await SharedPreferences.getInstance();
    // この関数が終わらないと遷移しないため
    ProviderScope.containerOf(context).updateOverrides([
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ]);
    UserState? userState = await ref.read(userSharedPreferencesRepositoryProvider).get();
    await ref.read(userViewModelProvider.notifier).init();

    debugPrint("done");

    // 通知権限
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      await android.requestNotificationsPermission();
    }
    UsageStats.grantUsagePermission();

    if (userState == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return;
    }

    var token = Token;
    bool isCall = false;
    bool isSouguuMutable = isSouguu;

    if (isSouguuMutable) {
      // 遭遇通知がくるまでまつ
      int counter = 0;
      while (counter < 30) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (ref.read(souguuServiceInfoProvider).restSouguuNotification != null) {
          transaction.finish();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/call');
          });
          logger.d('souguu notification received from service');
          break;
        } else {
          counter++;
        }
      }
      if (counter == 30) {
        logger.w("souguu notification not received");
        isSouguuMutable = false;
      }
    }

    transaction.startChild("get token");
    if (Token.isEmpty) {
      token = await ref.read(userViewModelProvider.notifier).refreshToken(userState.id, userState.refreshToken);
    } else {
      token = Token;
      ref.read(userViewModelProvider.notifier).setToken(token);
    }
    transaction.startChild("get souguuInfo");
    if (!isSouguuMutable) {
      isCall = await ref.read(souguuServiceInfoProvider.notifier).init();
    }
    await initService();

    logger.d("splash done");
    transaction.finish();

    if (isSouguuMutable) {
      return;
    }

    if (token.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return;
    }

    if (isCall) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/call');
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
      });
    }
    return;
  }

  Future<void> initService() async {
    if (!(await FlutterForegroundTask.isRunningService)) {
      DeveloperWidgets.initService();
      await Future.delayed(const Duration(milliseconds: 500));
      startService();
    }
  }

  Future<ServiceRequestResult> startService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        notificationIcon: null,
        notificationButtons: [
          const NotificationButton(id: '再起動', text: 'restart'),
          const NotificationButton(id: '停止', text: 'stop'),
        ],
        callback: startCallback,
      );
    }
  }
}
