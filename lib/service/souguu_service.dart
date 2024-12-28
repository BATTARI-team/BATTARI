import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/model/dto/app_service_communication/souguu_notification_between_app_and_service_dto.dart';
import 'package:battari/model/dto/rest_souguu_notification.dart';
import 'package:battari/model/dto/websocket/cancel_call_websocket_dto.dart';
import 'package:battari/model/dto/websocket/souguu_material_websocket_dto.dart';
import 'package:battari/model/dto/websocket/websocket_dto.dart';
import 'package:battari/model/dto/websocket/websocket_souguu_notification.dart';
import 'package:battari/model/souguu_incredient/souguu_app_incredient_model.dart';
import 'package:battari/model/souguu_incredient/souguu_incredient_data_appusage_model.dart';
import 'package:battari/model/state/souguu_service_state.dart';
import 'package:battari/model/state/user_state.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/service/notification_service.dart';
import 'package:battari/service/websocket_service.dart';
import 'package:battari/util/call_util.dart';
import 'package:battari/util/time_util.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:screen_state/screen_state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usage_stats/usage_stats.dart';

part 'souguu_service.g.dart';

@Riverpod(keepAlive: false)
class SouguuService extends _$SouguuService {
  ProviderSubscription<WebsocketService>? websocketProviderSubscription;
  ProviderSubscription<NotificationService>? notificationServiceSubscription;
  int? _lastOpenTimeStamp;
  List<EventUsageInfo> _events = [];
  // ignore: unused_field
  Timer? _untilCallStartTimer;
  Timer? _refreshTokenTimer;
  Timer? _appUsageGetter;
  Timer? _souguuIncredientSender;
  Timer? _isHomeGetterTimer;

  final souguuMaterialDuration = const Duration(seconds: 10);
  final appUsageDuration = const Duration(seconds: 10);

  int? userId;

  StreamSubscription<ScreenStateEvent>? _screenStateEventSubscription;

  bool isHome = false;
  bool isLock = false;
  Function(CancelCallWebsocketDto dto)? cancelCallListener;

  SouguuAppIncredientModel? appData;
  dealNotification(String p0) async {
    if (p0 != "battari") {
      logger.d("websocketで受信したデータ: $p0");
      await Sentry.captureMessage("websocketで受信したデータ: $p0", level: SentryLevel.debug);
    }
    // ここで受信したデータを処理する
    if (p0.length > 20) {
      debugPrint("0");
      try {
        var dto = WebsocketDto.fromJson(jsonDecode(p0));
        debugPrint("1");
        if (dto.type == "notification") {
          if (isLock) {
            await CallUtil.cancelCall("相手がオフラインになりました");
          }
          debugPrint("2");
          var notif = WebsocketSouguuNotification.fromJson(dto.data);
          debugPrint("3");
          ref
              .read(souguuServiceInfoProvider.notifier)
              .setSouguu(notif.aiteUserId, restSouguuNotification: RestSouguuNotification.fromWebsocketNotification(notif));
          if (await FlutterForegroundTask.isAppOnForeground) {
            try {
              logger.d(dto);
              var serviceNotificationDto = SouguuNotificationBetweenAppAndServiceDto(websocketDto: dto.toJson(), token: Token);
              logger.d("toJson成功");
              // ここまではきてる
              FlutterForegroundTask.sendDataToMain(jsonEncode(serviceNotificationDto));
              // navigatorKey.currentContext!.pushReplacementNamed("/call");
            } catch (e) {
              logger.e("画面遷移に失敗しました： $e", error: e, stackTrace: StackTrace.current);
              await Sentry.captureException(e, stackTrace: StackTrace.current);
              var serviceNotificationDto = SouguuNotificationBetweenAppAndServiceDto(websocketDto: dto.toJson(), token: Token);
              FlutterForegroundTask.sendDataToMain(jsonEncode(serviceNotificationDto));
            }
          } else {
            int diffrenceFromOfficialTime = DateTime.now().difference(DateTime.now()).inSeconds;
            debugPrint("4");
            try {
              var now = await TimeUtil.getOfficialTime();
              diffrenceFromOfficialTime = DateTime.now().difference(now).inSeconds;
            } catch (e) {
              logger.e("ntp error", error: e, stackTrace: StackTrace.current);
            }

            void onAppOpened(Timer timer) async {
              if (_untilCallStartTimer == null) {
                logger.w("untilCallStartTimer is null");
              }
              timer.cancel();
              bool _isForeground = await FlutterForegroundTask.isAppOnForeground;
              await Future.delayed(const Duration(milliseconds: 200), () {
                var serviceNotificationDto = SouguuNotificationBetweenAppAndServiceDto(websocketDto: dto.toJson(), token: Token);
                FlutterForegroundTask.sendDataToMain(jsonEncode(serviceNotificationDto));
                logger.i(serviceNotificationDto.toJson());
              });
              await Future.delayed(const Duration(milliseconds: 500), () {
                var serviceNotificationDto = SouguuNotificationBetweenAppAndServiceDto(websocketDto: dto.toJson(), token: Token);
                FlutterForegroundTask.sendDataToMain(jsonEncode(serviceNotificationDto));
                logger.i(serviceNotificationDto.toJson());
              });
              Future.delayed(const Duration(milliseconds: 1500), () {
                var serviceNotificationDto = SouguuNotificationBetweenAppAndServiceDto(websocketDto: dto.toJson(), token: Token);
                FlutterForegroundTask.sendDataToMain(jsonEncode(serviceNotificationDto));
                logger.i(serviceNotificationDto.toJson());
              });
            }

            void onTimerDone(Timer timer) {
              FlutterForegroundTask.launchApp("/foreground_init");
              onAppOpened(timer);
            }

            cancelCallListener = ((dto) {
              _untilCallStartTimer?.cancel();
              _untilCallStartTimer = null;
              ref.read(notificationServiceProviderProvider).cancelCounter();
              ref.read(notificationServiceProviderProvider).showCallCancel(dto);
              //#TODO もしフォアグラウンドだったら，通話がキャンセルされたよ画面に遷移する
            });
            debugPrint("5");

            bool _isForegroundOnTimerStart = await FlutterForegroundTask.isAppOnForeground;
            _untilCallStartTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
              bool _isForeground = await FlutterForegroundTask.isAppOnForeground;
              if ((_isForegroundOnTimerStart != true) && (_isForeground == true)) {
                onAppOpened(timer);
              } else {
                int remain = ref
                        .read(souguuServiceInfoProvider)
                        .restSouguuNotification
                        ?.callStartTime
                        .difference(DateTime.now().subtract(Duration(seconds: diffrenceFromOfficialTime)))
                        .inSeconds ??
                    0;
                if (ref
                        .read(souguuServiceInfoProvider)
                        .restSouguuNotification
                        ?.callStartTime
                        .compareTo(DateTime.now().subtract(Duration(seconds: diffrenceFromOfficialTime))) ==
                    -1) {
                  onTimerDone(timer);
                }
                if (notificationServiceSubscription != null && !notificationServiceSubscription!.closed) {
                  notificationServiceSubscription?.read().showCounter(remain, notif.aiteUserId);
                  Sentry.captureMessage("show counter", level: SentryLevel.debug);
                } else {
                  logger.w("notificationServiceSubscription is null or closed");
                  Sentry.captureMessage("notificationServiceSubscription is null or closed");
                  notificationServiceSubscription = ref.listen(notificationServiceProviderProvider, (previous, next) {});
                }
              }
            });
          }
        }
        if (dto.type == "cancel_call") {
          var cancelCallDto = CancelCallWebsocketDto.fromJson(dto.data);
          cancelCallListener?.call(cancelCallDto);
          cancelCallListener = null;
          if (await FlutterForegroundTask.isAppOnForeground) {
            FlutterForegroundTask.sendDataToMain(jsonEncode(dto));
          }
        }
      } catch (e) {
        logger.e("遭遇通知のパースに失敗しました: $e", error: e, stackTrace: StackTrace.current);
        await Sentry.captureException(e, stackTrace: StackTrace.current);
      }
    }
  }

  Future<void> _refreshToken() async {
    var shared = await SharedPreferences.getInstance();
    try {
      await http
          .post(Uri.parse('http://$ipAddress:5050/User/RefreshToken'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, Object>{
                'refreshToken': shared.getString("refresh_token")!,
                'userIndex': shared.getInt('id')!,
              }))
          .then((value) {
        if (value.statusCode == 200) {
          Token = value.body;
          ref.read(userViewModelProvider.notifier).setToken(Token);
        } else {
          logger.e("refresh token failed");
          Sentry.captureMessage("refresh token failed", level: SentryLevel.error);
        }
      });
    } catch (e) {
      logger.e("battari service started error", error: e, stackTrace: StackTrace.current);
    }
  }

  ProviderSubscription? souguuServiceInfoProviderSubscription;

  // 遭遇したい時
  void _setWebsocketProviderSubs() {
    if (websocketProviderSubscription == null) {
      websocketProviderSubscription = ref.listen(websocketServiceProvider, (previous, next) {});
      _refreshToken();
      ref.read(websocketServiceProvider).addWebsocketReceiver(dealNotification);
    }
  }

  final int distanceHome = 20;
  Future<bool> _isHome(Position position, UserState user) async {
    if (isLock) return false;
    var user = await ref.read(userSharedPreferencesRepositoryProvider).get();
    var _isHome = Geolocator.distanceBetween(
            position.latitude, position.longitude, user != null ? user.houseLatitude : 0, user != null ? user.houseLongitude : 0) <
        distanceHome;
    if (user == null) {
      logger.d("user is null");
    } else {
      logger.d(
          "distance: ${Geolocator.distanceBetween(position.latitude, position.longitude, user.houseLatitude, user.houseLongitude)}, position.latitude: ${position.latitude}, position.long: ${position.longitude}, user.houseLatitude: ${user.houseLatitude}, user.houseLong: ${user.houseLongitude}, result is : $_isHome");
    }
    return _isHome;
  }

  bool isConnectOk() {
    logger.d("isConnectOk: ${isHome && !isLock}, isHome: $isHome, isLock: $isLock");
    return (isHome && !isLock);
  }

  @override
  int build() {
    log("souguu service build");

    _init();

    if (isConnectOk()) {
      _setWebsocketProviderSubs();
    }

    //#TODO 2分に戻す
    _isHomeGetterTimer = Timer.periodic(const Duration(seconds: 20), (timer) async => _isHomeGetter());
    _isHomeGetter();
    //#TODO 大体タイマーは役割が一緒だからそれらの関数をインターフェースかしたい

    souguuServiceInfoProviderSubscription = ref.listen<SouguuServiceState>(souguuServiceInfoProvider, (previus, next) {});

    _refreshTokenTimer = Timer.periodic(const Duration(hours: 3), (timer) async {
      await _refreshToken();
    });

    _screenStateEventSubscription = Screen().screenStateStream.listen((ScreenStateEvent data) async {
      if (data == ScreenStateEvent.SCREEN_ON) {
        // 画面がONになった時の処理
        logger.i("screen on");
        isLock = false;
        if (isConnectOk()) {
          if (websocketProviderSubscription != null) {
            ref.read(websocketServiceProvider).needConnect();
          } else {
            _setWebsocketProviderSubs();
          }
        }
      } else if (data == ScreenStateEvent.SCREEN_OFF) {
        // 画面がOFFになった時の処理
        isLock = true;
        await CallUtil.cancelCall("相手がオフラインになりました");
        logger.i("screen off");
        disconnectWebsocket();
      }
    });
    _souguuIncredientSender = Timer.periodic(souguuMaterialDuration, (timer) {
      userId ??= ref.read(userViewModelProvider)?.id;
      if (userId == null || websocketProviderSubscription == null) return;
      List<Map<String, dynamic>> incredients = [];
      // 遭遇材料の追加
      if (appData != null) {
        incredients.add(appData!.toJson());
      }
      // var output =
      //     jsonEncode(SouguuWebsocketDto(id: userId!, isWelcome: false, incredients: incredients, created: DateTime.now()).toJson());
      var output = jsonEncode(WebsocketDto(
              type: "souguu_materials",
              data: SouguuMaterialWebsocketDto(id: userId!, isWelcome: false, incredients: incredients, created: DateTime.now()).toJson())
          .toJson());

      if (websocketProviderSubscription != null) {
        if (!websocketProviderSubscription!.closed) websocketProviderSubscription!.read().sendMessage(output);
      }
    });
    _appUsageGetter = Timer.periodic(appUsageDuration, (timer) async {
      await _checkAppUsage();
    });

    notificationServiceSubscription = ref.listen(notificationServiceProviderProvider, (previous, next) {});

    return 0;
  }

  Future<void> _init() async {
    await _initUsage();
  }

  void _isHomeGetter() async {
    var user = ref.read(userViewModelProvider);
    if (user == null) {
      logger.d('user is null');
      isHome = false;
      return;
    }
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //if (position.latitude == user.houseLatitude && position.longitude == user.houseLongitude) {
    if ((await _isHome(position, user))) {
      logger.d('isHome: $isHome, $position, $user');
      if (isHome == false) {
        isHome = true;

        if (isConnectOk()) {
          if (websocketProviderSubscription != null) {
            ref.read(websocketServiceProvider).needConnect();
          } else {
            _setWebsocketProviderSubs();
          }
        }
      }
    } else {
      if (isHome == true) {
        isHome = false;
        disconnectWebsocket();
      }
    }
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
      await Sentry.captureException(err, stackTrace: StackTrace.current);
      print(err);
    }
  }

  void dispose() {
    debugPrint("souguu service dispose");
    websocketProviderSubscription?.close();
  }

  //遭遇できなくなったら実行する
  void disconnectWebsocket() async {
    logger.d("disconnect websocket");
    await websocketProviderSubscription?.read().cancelConnect();
    websocketProviderSubscription?.close();
    await Sentry.captureMessage("websocket disconnected", level: SentryLevel.debug);

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
    var transaction = Sentry.startTransaction("Splash.init", "SouguuServiceInfo.init");
    logger.d("get souguu info");
    try {
      var result = await http.get(Uri.parse('http://$ipAddress:5050/SouguuInfo/GetSouguuInfo'), headers: <String, String>{
        'Authorization': 'Bearer $Token',
      });
      transaction.startChild("parse result");
      logger.d("souguu_service.dart, _init statuscode: ${result.statusCode}, token: $Token");
      if (result.statusCode != 200) {
        transaction.finish();
        return false;
      } else {
        var souguuInfo = RestSouguuNotification.fromJson(jsonDecode(result.body));
        state = state.copyWith(souguu: souguuInfo.aiteUserId, restSouguuNotification: souguuInfo);
        logger.i("${souguuInfo.aiteUserId}と遭遇しました");
        transaction.finish();
        return true;
      }
    } catch (e) {
      logger.e("souguu_service.dart, _init: 遭遇情報の取得に失敗しました", error: e, stackTrace: StackTrace.current);
      await Sentry.captureException(e, stackTrace: StackTrace.current);
    }
    logger.d("init done");
    transaction.finish();
    return false;
  }

  /// 現在遭遇しているかの情報を更新する
  void setSouguu(int? souguu, {RestSouguuNotification? restSouguuNotification}) {
    state = state.copyWith(souguu: souguu ?? 0, restSouguuNotification: restSouguuNotification);
  }

  void setCancel(String reason) {
    state = state.copyWith(cancelReason: 'test');
  }
}
