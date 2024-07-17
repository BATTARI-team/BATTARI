import 'package:battari/background_service.dart';
import 'package:battari/battari_confg.dart';
import 'package:battari/main.dart';
import 'package:battari/notification_service.dart';
import 'package:battari/wait_for_call_notifier_provider.dart';
import 'package:battari/wait_for_call_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod/riverpod.dart';

class SouguuService {
  final ProviderRef<SouguuService> ref;
  SouguuService(this.ref);
  void Souguu() async {
    final state = ref.read(flutterLocalNotificationsPluginProvider);
    while (countdown >= 0) {
      await Future.delayed(Duration(seconds: 1));
      if (countdown == 0) {
        state.clearCountdownNotification();
        FlutterForegroundTask.launchApp();
        ref.read(waitForCallNotifierProvider.notifier).startCall();

        Navigator.of(navigatorKey.currentContext!)
            .push(MaterialPageRoute(builder: (context) => WaitForCall()));
        return;
      }
      if (countdown < 3) {
        await state.showCountdownNotification(
            userName, countdown--, true, true);
      } else {
        await state.showCountdownNotification(
            userName, countdown--, false, false);
      }
    }
  }
}

final souguuServiceProvider =
    Provider<SouguuService>((ref) => SouguuService(ref));
