import 'dart:convert';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/model/dto/app_service_communication/souguu_notification_dto.dart';
import 'package:battari/model/dto/rest_souguu_notification.dart';
import 'package:battari/model/dto/websocket/websocket_dto.dart';
import 'package:battari/model/dto/websocket/websocket_souguu_notification.dart';
import 'package:battari/routes.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:flutter/material.dart';
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
    debugPrint(p0);
    try {
      // var notif = WebsocketSouguuNotification.fromJson(jsonDecode(p0));
      var fromService = SouguuNotificationDto.fromJson(jsonDecode(p0));
      Sentry.captureMessage('fromService parsed', level: SentryLevel.debug);
      logger.d(fromService);
      var dto = WebsocketDto.fromJson(fromService.websocketDto);
      Sentry.captureMessage('websocketDto parsed', level: SentryLevel.debug);
      Token = fromService.token;
      logger.d(dto);
      if (dto.type == 'notification') {
        var notif = WebsocketSouguuNotification.fromJson(dto.data);
        Sentry.captureMessage('WebsocketSouguuNotification parsed', level: SentryLevel.debug);
        ref
            .read(souguuServiceInfoProvider.notifier)
            .setSouguu(notif.aiteUserId, restSouguuNotification: RestSouguuNotification.fromWebsocketNotification(notif));
        if (await FlutterForegroundTask.isAppOnForeground) {
          try {
            router.go("/foreground_init");
            // navigatorKey.currentContext!.pushReplacementNamed("/call");
          } catch (e) {
            logger.e("画面遷移に失敗しました： $e", error: e, stackTrace: StackTrace.current);
            await Sentry.captureException(e, stackTrace: StackTrace.current);
          }
        }
      }
    } catch (e) {
      logger.e("遭遇通知のパースに失敗しました: $e", error: e, stackTrace: StackTrace.current);
      await Sentry.captureException(e, stackTrace: StackTrace.current);
    }
  }
}
