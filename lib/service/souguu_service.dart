import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/model/dto/rest_souguu_notification.dart';
import 'package:battari/model/dto/souguu_websocket_dto.dart';
import 'package:battari/model/dto/websocket_souguu_notification.dart';
import 'package:battari/model/souguu_incredient/souguu_app_incredient_model.dart';
import 'package:battari/model/souguu_incredient/souguu_incredient_data_appusage_model.dart';
import 'package:battari/model/state/souguu_service_state.dart';
import 'package:battari/model/state/user_state.dart';
import 'package:battari/routes.dart';
import 'package:battari/service/notification_service.dart';
import 'package:battari/service/websocket_service.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_ntp/flutter_ntp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:screen_state/screen_state.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:http/http.dart' as http;

part 'souguu_service.g.dart';

@Riverpod(keepAlive: false)
class SouguuService extends _$SouguuService {
  ProviderSubscription<WebsocketService>? websocketProviderSubscription;
  ProviderSubscription<NotificationService>? notificationServiceSubscription;
  int? _lastOpenTimeStamp;
  List<EventUsageInfo> _events = [];
  // ignore: unused_field
  Timer? _untilCallStartTimer;
  Timer? _appUsageGetter;
  Timer? _souguuIncredientSender;
  Timer? _isHomeGetterTimer;

  int? userId;

  StreamSubscription<ScreenStateEvent>? _screenStateEventSubscription;
  bool isHome = false;

  SouguuAppIncredientModel? appData;
  dealNotification(String p0, [bool fromForegroundApp = false]) async {
    if (p0 != "battari") {
      logger.d("websocketで受信したデータ: $p0");
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
            logger.i("foreground, fromForegroundApp: $fromForegroundApp");
            if (fromForegroundApp) {
              router.go("/");
            } else {
              FlutterForegroundTask.sendDataToMain(p0);
            }
            // navigatorKey.currentContext!.pushReplacementNamed("/call");
          } catch (e) {
            logger.e("画面遷移に失敗しました： $e", error: e, stackTrace: StackTrace.current);
            if (!fromForegroundApp) {
              FlutterForegroundTask.sendDataToMain(p0);
            }
          }
        } else {
          logger.i("background");
          var now = await FlutterNTP.now();
          var differenceFromOfficialTime = DateTime.now().difference(now).inSeconds;

          _untilCallStartTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
            int remain = ref
                    .read(souguuServiceInfoProvider)
                    .restSouguuNotification
                    ?.callStartTime
                    .difference(DateTime.now().subtract(Duration(seconds: differenceFromOfficialTime)))
                    .inSeconds ??
                0;
            if (ref
                    .read(souguuServiceInfoProvider)
                    .restSouguuNotification
                    ?.callStartTime
                    .compareTo(DateTime.now().subtract(Duration(seconds: differenceFromOfficialTime))) ==
                -1) {
              timer.cancel();
              FlutterForegroundTask.launchApp("/");
              Future.delayed(const Duration(seconds: 1), () {
                FlutterForegroundTask.sendDataToMain(p0);
              });
            }
            if (notificationServiceSubscription != null && !notificationServiceSubscription!.closed) {
              notificationServiceSubscription?.read().showCounter(remain, notif.aiteUserId);
            }
          });
        }
      } catch (e) {
        logger.e("遭遇通知のパースに失敗しました: $e", error: e, stackTrace: StackTrace.current);
      }
    }
  }

  ProviderSubscription? souguuServiceInfoProviderSubscription;

  // 遭遇したい時
  void _setWebsocketProviderSubs() {
    if (websocketProviderSubscription == null) {
      websocketProviderSubscription = ref.listen(websocketServiceProvider, (previous, next) {});
      ref.read(websocketServiceProvider).addWebsocketReceiver(dealNotification);
    }
  }

  final int distanceHome = 10;
  bool _isHome(Position position, UserState user) {
    return Geolocator.distanceBetween(position.latitude, position.longitude, user.houseLatitude, user.houseLongitude) < distanceHome;
  }

  @override
  int build() {
    log("souguu service build");
    _init();
    _setWebsocketProviderSubs();
    _isHomeGetterTimer = Timer.periodic(const Duration(seconds: 120), (timer) async {
      var user = ref.read(userViewModelProvider).maybeWhen(
          orElse: () => null,
          data: (data) {
            if (data == null) return null;
            return data;
          });
      if (user == null) {
        isHome = false;
        return;
      }
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      //if (position.latitude == user.houseLatitude && position.longitude == user.houseLongitude) {
      if (_isHome(position, user)) {
        if (isHome == false) {
          isHome = true;
          _setWebsocketProviderSubs();
        }
      } else {
        if (isHome == true) {
          isHome = false;
          disconnectWebsocket();
        }
      }
    });
    souguuServiceInfoProviderSubscription = ref.listen<SouguuServiceState>(souguuServiceInfoProvider, (previus, next) {});
    _screenStateEventSubscription = Screen().screenStateStream.listen((ScreenStateEvent data) {
      if (data == ScreenStateEvent.SCREEN_ON) {
        // 画面がONになった時の処理
        logger.i("screen on");
        if (websocketProviderSubscription != null) {
          ref.read(websocketServiceProvider).needConnect();
        } else {
          _setWebsocketProviderSubs();
        }
      } else if (data == ScreenStateEvent.SCREEN_OFF) {
        // 画面がOFFになった時の処理
        logger.i("screen off");
        disconnectWebsocket();
      }
    });
    _souguuIncredientSender = Timer.periodic(const Duration(minutes: 1), (timer) {
      userId ??= ref.read(userViewModelProvider).maybeWhen(
          orElse: () => null,
          data: (data) {
            if (data == null) return null;
            return data.id;
          });
      if (userId == null || websocketProviderSubscription == null) return;
      List<Map<String, dynamic>> incredients = [];
      // 遭遇材料の追加
      if (appData != null) {
        incredients.add(appData!.toJson());
      }
      var output =
          jsonEncode(SouguuWebsocketDto(id: userId!, isWelcome: false, incredients: incredients, created: DateTime.now()).toJson());

      if (websocketProviderSubscription != null) {
        if (!websocketProviderSubscription!.closed) websocketProviderSubscription!.read().sendMessage(output);
      }
    });
    _appUsageGetter = Timer.periodic(const Duration(seconds: 30), (timer) async {
      await _checkAppUsage();
    });
    notificationServiceSubscription = ref.listen(notificationServiceProviderProvider, (previous, next) {});

    return 0;
  }

  Future<void> _init() async {
    await _initUsage();
  }

  Future<void> _checkAppUsage() async {
    if (_lastOpenTimeStamp != null) {
      await _initUsage();
      DateTime currentTime = DateTime.now();
      DateTime lastOpenTime = DateTime.fromMillisecondsSinceEpoch(_lastOpenTimeStamp!);

      // 経過時間を秒で計算
      // ignore: unused_local_variable
      // #TODO
      int elapsedMinutes = currentTime.difference(lastOpenTime).inSeconds ~/ 60;
      int elapsedSeconds = currentTime.difference(lastOpenTime).inSeconds.toInt();

      String appName = _events.firstWhere((event) => event.timeStamp == _lastOpenTimeStamp.toString()).packageName ?? "不明なアプリ";

      DateTime now = DateTime.now(); // 現在の時間を取得

      print("$appName:$elapsedSeconds経過"); // _targetSeconds以下なら経過秒数を表示
      appData =
          SouguuAppIncredientModel(type: "app", appData: SouguuIncredientDataAppUsageModel(appName: appName, useTime: elapsedSeconds));
    } else {
      appData = null;
    }
  }

  Future<void> _initUsage() async {
    try {
      UsageStats.grantUsagePermission();

      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 1));

      List<EventUsageInfo> queryEvents = await UsageStats.queryEvents(startDate, endDate);

      // 最新の eventType == 1 イベントのタイムスタンプを取得
      for (var event in queryEvents.reversed) {
        if (event.eventType == '1') {
          _lastOpenTimeStamp = int.parse(event.timeStamp!);
          break; // 最新のイベントのみを使用するため、最初に見つかったらループを抜ける
        }
        // print("_lastOpenTimeStamp: $_lastOpenTimeStamp");
      }
      _events = queryEvents.reversed.toList();
    } catch (err) {
      print(err);
    }
  }

  void dispose() {
    debugPrint("souguu service dispose");
    websocketProviderSubscription?.close();
  }

  //遭遇できなくなったら実行する
  void disconnectWebsocket() async {
    await websocketProviderSubscription?.read().cancelConnect();
    websocketProviderSubscription?.close();

    await http.get(Uri.parse('http://$ipAddress:5050/SouguuInfo/ClearSouguuIncredient'), headers: <String, String>{
      'Authorization': 'Bearer $Token',
    });
    websocketProviderSubscription = null;
  }
}

/// 遭遇しているかなどの情報を保持するプロバイダー
@Riverpod(keepAlive: true)
class SouguuServiceInfo extends _$SouguuServiceInfo {
  @override
  SouguuServiceState build() {
    ref.onDispose(() {
      log("souguu service info dispose");
    });
    log("souguu service info build");
    return SouguuServiceState();
  }

  Future<bool> init() async {
    try {
      var result = await http.get(Uri.parse('http://$ipAddress:5050/SouguuInfo/GetSouguuInfo'), headers: <String, String>{
        'Authorization': 'Bearer $Token',
      });
      logger.d("souguu_service.dart, _init statuscode: ${result.statusCode}");
      if (result.statusCode != 200) {
        return false;
      } else {
        var souguuInfo = RestSouguuNotification.fromJson(jsonDecode(result.body));
        state = state.copyWith(souguu: souguuInfo.aiteUserId, restSouguuNotification: souguuInfo);
        logger.i("${souguuInfo.aiteUserId}と遭遇しました");
        return true;
      }
    } catch (e) {
      logger.e("souguu_service.dart, _init: 遭遇情報の取得に失敗しました", error: e, stackTrace: StackTrace.current);
    }
    return false;
  }

  /// 現在遭遇しているかの情報を更新する
  void setSouguu(int? souguu, {RestSouguuNotification? restSouguuNotification}) {
    state = state.copyWith(souguu: souguu ?? 0, restSouguuNotification: restSouguuNotification);
  }
}
