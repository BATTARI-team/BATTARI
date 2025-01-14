import 'dart:convert';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/model/dto/app_service_communication/souguu_notification_between_app_and_service_dto.dart';
import 'package:battari/model/dto/rest_souguu_notification.dart';
import 'package:battari/model/dto/websocket/websocket_dto.dart';
import 'package:battari/model/dto/websocket/websocket_souguu_notification.dart';
import 'package:battari/routes.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/view_model/is_home_view_model.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'websocket_parser.g.dart';

Future<void> Function(WebsocketDto dto)? dealNotificationListener;

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
      var fromService = SouguuNotificationBetweenAppAndServiceDto.fromJson(jsonDecode(p0));
      var dto = WebsocketDto.fromJson(fromService.websocketDto);

      if (dto.type == "is_home") {
        if (dealNotificationListener != null) {
          await dealNotificationListener!(dto);
        }
        ref.read(isHomeViewModelProvider.notifier).setIsHome(dto.data['is_home'] as bool);
        return;
      }
      if (fromService.token.isNotEmpty) {
        Token = fromService.token;
      } else {
        ref.read(userViewModelProvider.notifier).refreshToken();
        Sentry.captureMessage("websocketで受信したデータにトークンがありません", level: SentryLevel.warning);
      }
      logger.d(dto);
      if (dto.type == 'notification') {
        var souguuInfo = ref.read(souguuServiceInfoProvider);
        var notif = WebsocketSouguuNotification.fromJson(dto.data);
        if (souguuInfo.restSouguuNotification != null) {
          if (souguuInfo.restSouguuNotification!.callId == notif.callId) {
            logger.d("同じ通話IDの通知が来ました。無視します。");
            return;
          }
        }
        ref
            .read(souguuServiceInfoProvider.notifier)
            .setSouguu(notif.aiteUserId, restSouguuNotification: RestSouguuNotification.fromWebsocketNotification(notif));
        if (await FlutterForegroundTask.isAppOnForeground) {
          try {
            router.go("/foreground_init");
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
