import 'package:flutter_ntp/flutter_ntp.dart';

class TimeUtil {
  static Future<DateTime> getOfficialTime() async {
    var differenceFromOfficialTime = DateTime.now().difference(await FlutterNTP.now()).inSeconds;
    return DateTime.now().subtract(Duration(seconds: differenceFromOfficialTime));
  }
}
