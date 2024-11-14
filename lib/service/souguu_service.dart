import 'dart:convert';

import 'package:battari/model/dto/websocket_souguu_notification.dart';
import 'package:battari/model/state/souguu_service_state.dart';
import 'package:battari/service/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'souguu_service.g.dart';

@Riverpod(keepAlive: true)
class SouguuService extends _$SouguuService {
  _dealNotification(String p0) {
    // ここで受信したデータを処理する
    if (p0.length > 20) {
      try {
        var notif = WebsocketSouguuNotification.fromJson(jsonDecode(p0));
        debugPrint("受信したデータ: ${notif.souguuReason}");
        ref.read(souguuServiceInfoProvider.notifier).setSouguu(notif.aiteUserId);
      } catch (e) {
        debugPrint("受信したデータ: ${e.toString()}");
      }
    }
  }

  ProviderSubscription? websocketProviderSubscription = ProviderContainer().listen(websocketServiceProvider, (previous, next) {});
  ProviderSubscription? souguuServiceInfoProviderSubscription;

  @override
  int build() {
    websocketProviderSubscription = ref.listen(websocketServiceProvider, (previous, next) {});
    ref.read(websocketServiceProvider).addWebsocketReceiver(_dealNotification);
    //ref.listen<SouguuServiceState>(souguuServiceProvider, (previous, next) {
    //  if (next.souguu != 0) {
    //    disconnectWebsocket();
    //  } else {
    //    websocketProviderSubscription = ProviderContainer().listen(websocketServiceProvider, (previous, next) {});
    //  }
    //});
    souguuServiceInfoProviderSubscription = ref.listen<SouguuServiceState>(souguuServiceInfoProvider, (previus, next) {
      if (next.souguu != 0) {
        disconnectWebsocket();
      } else {
        //　遭遇状態から抜けたら再接続
        if (websocketProviderSubscription != null) {
          websocketProviderSubscription = ProviderContainer().listen(websocketServiceProvider, (previous, next) {});
          ref.read(websocketServiceProvider).addWebsocketReceiver((p0) => _dealNotification(p0));
        }
      }
    });

    return 0;
  }

  void dispose() {
    websocketProviderSubscription?.close();
  }

  void disconnectWebsocket() {
    websocketProviderSubscription?.close();
    websocketProviderSubscription = null;
  }
}

/// 遭遇しているかなどの情報を保持するプロバイダー
@Riverpod(keepAlive: true)
class SouguuServiceInfo extends _$SouguuServiceInfo {
  @override
  SouguuServiceState build() {
    return SouguuServiceState();
  }

  /// 現在遭遇しているかの情報を更新する
  void setSouguu(int? souguu) {
    state = state.copyWith(souguu: souguu ?? 0);
  }
}
