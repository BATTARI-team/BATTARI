import 'dart:convert';
import 'dart:developer';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/model/dto/rest_souguu_notification.dart';
import 'package:battari/model/dto/websocket_souguu_notification.dart';
import 'package:battari/model/state/souguu_service_state.dart';
import 'package:battari/service/websocket_service.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'souguu_service.g.dart';

@Riverpod(keepAlive: false)
class SouguuService extends _$SouguuService {
  ProviderSubscription? websocketProviderSubscription;
  _dealNotification(String p0) {
    logger.d("websocketで受信したデータ: $p0");
    // ここで受信したデータを処理する
    if (p0.length > 20) {
      try {
        var notif = WebsocketSouguuNotification.fromJson(jsonDecode(p0));
        ref.read(souguuServiceInfoProvider.notifier).setSouguu(notif.aiteUserId);
        FlutterForegroundTask.launchApp("/");
      } catch (e) {
        logger.e("遭遇通知のパースに失敗しました: $e");
      }
    }
  }

  ProviderSubscription? souguuServiceInfoProviderSubscription;

  @override
  int build() {
    log("souguu service build");
    websocketProviderSubscription = ref.listen(websocketServiceProvider, (previous, next) {});
    ref.read(websocketServiceProvider).addWebsocketReceiver(_dealNotification);

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
    debugPrint("souguu service dispose");
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

  Future<bool> init() async {
    try {
      debugPrint("souguu_service.dart, _init: $Token");
      var result = await http.get(Uri.parse('http://$ipAddress:5050/SouguuInfo/GetSouguuInfo'), headers: <String, String>{
        'Authorization': 'Bearer $Token',
      });
      logger.d("souguu_service.dart, _init statuscode: ${result.statusCode}");
      if (result.statusCode != 200) {
        return false;
      } else {
        var souguuInfo = RestSouguuNotification.fromJson(jsonDecode(result.body));
        state = state.copyWith(souguu: souguuInfo.aiteUserId);
        logger.i("${souguuInfo.aiteUserId}と遭遇しました");
        return true;
      }
    } catch (e) {
      logger.e("souguu_service.dart, _init: 遭遇情報の取得に失敗しました", error: e, stackTrace: StackTrace.current);
    }
    return false;
  }

  /// 現在遭遇しているかの情報を更新する
  void setSouguu(int? souguu) {
    state = state.copyWith(souguu: souguu ?? 0);
  }
}
