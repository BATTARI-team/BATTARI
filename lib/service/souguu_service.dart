import 'dart:convert';

import 'package:battari/model/dto/websocket_souguu_notification.dart';
import 'package:battari/model/state/souguu_service_state.dart';
import 'package:battari/service/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'souguu_service.g.dart';

@Riverpod(keepAlive: true)
class SouguuService extends _$SouguuService {
  _dealNotification(String p0) {
    debugPrint("execute");
    // ここで受信したデータを処理する
    if (p0.length > 20) {
      try {
        var notif = WebsocketSouguuNotification.fromJson(jsonDecode(p0));
        debugPrint("受信したデータ: ${notif.souguuReason}");
        state = state.copyWith(souguu: notif.callId);
        debugPrint("callId: ${notif.callId}");
      } catch (e) {
        debugPrint("受信したデータ: ${e.toString()}");
      }
    }
  }

  @override
  SouguuServiceState build() {
    ref.watch(websocketServiceProvider);
    // #TODO ondisposeでsubscriptionを解除する
    ref.read(websocketServiceProvider).addWebsocketReceiver(_dealNotification);
    return SouguuServiceState();
  }
}
