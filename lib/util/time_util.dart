import 'package:battari/logger.dart';
import 'package:flutter_ntp/flutter_ntp.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class TimeUtil {
  static Future<DateTime> getOfficialTime() async {
    DateTime now = DateTime.now();
    try {
      now = await FlutterNTP.now();
    } catch (e) {
      Sentry.captureException(e);
      logger.e("getOfficialTime error", error: e, stackTrace: StackTrace.current);

      try {
        now = await FlutterNTP.now(lookUpAddress: 'nict.ntp.jp');
      } catch (e) {
        Sentry.captureException(e);
        logger.e("getOfficialTime error", error: e, stackTrace: StackTrace.current);
      }
    }
    return now;
  }
}
