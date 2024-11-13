import 'dart:convert';

import 'package:battari/model/dto/websocket_souguu_notification.dart';
import 'package:battari/model/state/souguu_service_state.dart';
import 'package:battari/service/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'souguu_service.g.dart';

@Riverpod(keepAlive: true)
class SouguuService extends _$SouguuService {
  final Function(String) _dealNotification = (p0) {
    debugPrint("execute");
    // ここで受信したデータを処理する
    if (p0.length > 20) {
      try {
        var notif = WebsocketSouguuNotification.fromJson(jsonDecode(p0));
        debugPrint("受信したデータ: ${notif.souguuReason}");
      } catch (e) {
        debugPrint("受信したデータ: ${e.toString()}");
      }
    }
  };

  @override
  SouguuServiceState build() {
    ref.watch(websocketServiceProvider);
    return SouguuServiceState();
  }
}
