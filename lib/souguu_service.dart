import 'package:battari/background_service.dart';
import 'package:battari/notification_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod/riverpod.dart';

class SouguuService {
  final ProviderRef<SouguuService> ref;
  SouguuService(this.ref);
  void Souguu() async {
    int countdown = 60;
    const userName = "たくと ";
    final state = ref.read(flutterLocalNotificationsPluginProvider);
    while (countdown >= 0) {
      await Future.delayed(Duration(seconds: 1));
      if (countdown == 0) {
        state.clearCountdownNotification();
        FlutterForegroundTask.launchApp();
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
