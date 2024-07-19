import 'package:battari/battari_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WaitForCallNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void startCall() {
    state = true;
  }

  void endCall() {
    countdown = countdown_max;
    state = false;
  }
}

final waitForCallNotifierProvider =
    NotifierProvider<WaitForCallNotifier, bool>(() => WaitForCallNotifier());
