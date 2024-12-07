// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/model/state/user_state.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usage_stats/usage_stats.dart';

class Splash extends HookConsumerWidget {
  const Splash({super.key});
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
    var sharedPreferences = await SharedPreferences.getInstance();
    // この関数が終わらないと遷移しないため
    ProviderScope.containerOf(context).updateOverrides([
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ]);
    UserState? userState = await ref.read(userSharedPreferencesRepositoryProvider).get();
    debugPrint("done");

    // 通知権限
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      await android.requestNotificationsPermission();
    }
    UsageStats.grantUsagePermission();
    if (userState != null) {
      var token = await ref.read(userViewModelProvider.notifier).refreshToken(userState.id, userState.refreshToken);
      var isCall = await ref.read(souguuServiceInfoProvider.notifier).init();

      if (token.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/login');
        });
        return;
      } else {
        if (isCall) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/call');
          });
        } else {
          // アプリサイドにデータを送信
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home');
          });
        }
        return;
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return;
    }
  }
}
