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
    if (userState != null) {
      var token = Token;
      bool isCall = false;

      var transaction = Sentry.startTransaction("Splash.init", "Splash.init/userstate!=null");

      if (isSouguu) {
        // 遭遇通知がくるまでまつ
        int counter = 0;
        while (counter < 10) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (ref.read(souguuServiceInfoProvider).restSouguuNotification != null) {
            transaction.finish();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/call');
            });
          } else {
            counter++;
          }
        }
      }

      transaction.startChild("get token");
      if (Token.isEmpty) {
        token = await ref.read(userViewModelProvider.notifier).refreshToken(userState.id, userState.refreshToken);
      } else {
        token = Token;
        ref.read(userViewModelProvider.notifier).setToken(token);
      }
      logger.i("isSouguu: $isSouguu");
      transaction.startChild("get souguuInfo");
      if (!isSouguu) {
        isCall = await ref.read(souguuServiceInfoProvider.notifier).init();
      }

      logger.d("splash done");
      transaction.finish();
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
