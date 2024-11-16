import 'dart:convert';
import 'dart:developer';

import 'package:battari/main.dart';
import 'package:battari/model/dto/rest_souguu_notification.dart';
import 'package:battari/model/dto/websocket_souguu_notification.dart';
import 'package:battari/model/state/souguu_service_state.dart';
import 'package:battari/repository/user_repository.dart';
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
    print("$p0");
    // ここで受信したデータを処理する
    if (p0.length > 20) {
      try {
        var notif = WebsocketSouguuNotification.fromJson(jsonDecode(p0));
        debugPrint("受信したデータ: ${notif.souguuReason}");
        ref.read(souguuServiceInfoProvider.notifier).setSouguu(notif.aiteUserId);
        FlutterForegroundTask.launchApp("/call");
      } catch (e) {
        debugPrint("受信したデータ: ${e.toString()}");
      }
    } else {
      debugPrint("p0 is too short");
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

int Souguu = 0;

/// 遭遇しているかなどの情報を保持するプロバイダー
@Riverpod(keepAlive: true)
class SouguuServiceInfo extends _$SouguuServiceInfo {
  @override
  SouguuServiceState build() {
    print("token from userviewmodel: ${ref.read(userViewModelProvider).asData?.value?.token}");
    print("token from Token: $Token");
    _init();

    return SouguuServiceState();
  }

  _init() async {
    try {
      var result = await http.get(Uri.parse('http://$IpAddress:5050/SouguuInfo/GetSouguuInfo'), headers: <String, String>{
        'Authorization': 'Bearer $Token',
      });
      print(result.statusCode);
      if (result.statusCode != 200) {
      } else {
        var souguuInfo = RestSouguuNotification.fromJson(jsonDecode(result.body));
        state = state.copyWith(souguu: souguuInfo.aiteUserId);
      }
    } catch (e) {
      print("souguu_service.dart, _init: $e");
    }
  }

  /// 現在遭遇しているかの情報を更新する
  void setSouguu(int? souguu) {
    debugPrint("setSouguu $souguu");
    Souguu = souguu ?? 100;
    state = state.copyWith(souguu: souguu ?? 0);
  }
}
