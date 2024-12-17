import 'dart:convert';

import 'package:battari/logger.dart';
import 'package:battari/model/dto/rest_souguu_notification.dart';
import 'package:battari/model/dto/websocket/websocket_souguu_notification.dart';
import 'package:battari/routes.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'websocket_parser.g.dart';

@riverpod
dealNotificationForForegroundApp(Ref ref, String p0) async {
  if (p0 != "battari") {
    logger.d("websocketで受信したデータ: $p0");
    await Sentry.captureMessage("websocketで受信したデータ: $p0", level: SentryLevel.debug);
  }
  // ここで受信したデータを処理する
  if (p0.length > 20) {
    try {
      var notif = WebsocketSouguuNotification.fromJson(jsonDecode(p0));
      ref
          .read(souguuServiceInfoProvider.notifier)
          .setSouguu(notif.aiteUserId, restSouguuNotification: RestSouguuNotification.fromWebsocketNotification(notif));
      if (await FlutterForegroundTask.isAppOnForeground) {
        try {
          router.go("/");
          // navigatorKey.currentContext!.pushReplacementNamed("/call");
        } catch (e) {
          logger.e("画面遷移に失敗しました： $e", error: e, stackTrace: StackTrace.current);
          await Sentry.captureException(e, stackTrace: StackTrace.current);
        }
      }
    } catch (e) {
      logger.e("遭遇通知のパースに失敗しました: $e", error: e, stackTrace: StackTrace.current);
      await Sentry.captureException(e, stackTrace: StackTrace.current);
    }
  }
}
