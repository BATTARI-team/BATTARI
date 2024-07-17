import 'package:battari/background_service.dart';
import 'package:battari/battari_config.dart';
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
    await Future.delayed(Duration(seconds: 3));
    final state = ref.read(flutterLocalNotificationsPluginProvider);
    while (countdown >= 0) {
      await Future.delayed(Duration(seconds: 1));
      if (countdown == 0) {
        state.clearCountdownNotification();
        FlutterForegroundTask.launchApp();
        ref.read(waitForCallNotifierProvider.notifier).startCall();

        ref
            .read(countdownNotifierProvider.notifier)
            .startCountdown(countdown, countdown);
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

class CountdownNotifier extends Notifier<CountdownState> {
  @override
  CountdownState build() {
    return CountdownState(seconds: 0, max: 0);
  }

  void updateSeconds() {
    state = CountdownState(seconds: state.seconds - 1, max: state.max);
  }

  void startCountdown(int seconds, int max) {
    state = CountdownState(seconds: seconds, max: max);
  }

  Future<void> _countDown() async {
    while (state.seconds > 0) {
      await Future.delayed(Duration(seconds: 1));
      updateSeconds();
    }
  }
}

@immutable
class CountdownState {
  final int seconds;
  final int max;

  CountdownState({required this.seconds, required this.max});
}

final countdownNotifierProvider =
    NotifierProvider<CountdownNotifier, CountdownState>(
        () => CountdownNotifier());
