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
    state = false;
  }
}

final waitForCallNotifierProvider =
    NotifierProvider<WaitForCallNotifier, bool>(() => WaitForCallNotifier());
