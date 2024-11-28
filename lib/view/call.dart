import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:battari/logger.dart';
import 'package:battari/main.dart';
import 'package:battari/model/dto/rest_souguu_notification.dart';
import 'package:battari/model/state/souguu_service_state.dart';
import 'package:battari/model/state/user_state.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/util/time_util.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_ntp/flutter_ntp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Call extends HookConsumerWidget {
  Call({super.key});
  late RtcEngine _engine;
  Timer? _timer;
  Timer? _callTimer;

  @override
  Widget build(BuildContext context, ref) {
    // 0: ローディング
    // 1: 通話待ち
    // 2: 通話中
    // 3: 通話終了
    var status = useState(0);
    var countdown = useState(0);
    int differenceFromOfficialTime = 0;
    var callCountdown = useState(0);
    SouguuServiceState souguuInfo = ref.watch(souguuServiceInfoProvider);
    UserState? userState = ref.watch(userViewModelProvider).asData!.value;
    if (souguuInfo.restSouguuNotification == null || userState == null) {
      // デフォルト値挿入
      souguuInfo = SouguuServiceState(
          restSouguuNotification: RestSouguuNotification(
              callEndTime: DateTime.now().add(const Duration(seconds: 20)),
              callId: 1,
              aiteUserId: 6,
              souguuDateTime: DateTime.now(),
              callStartTime: DateTime.now().add(const Duration(seconds: 10)),
              souguuReason: "instagramでBATTARI",
              token: "006f1e"));
      userState = const UserState(id: 6, userId: "test", name: "test", token: "006f1e");
    }

    useEffect(() {
      (() async {
        debugPrint("agora init");
        await _requestPermissionForAndroid();
        await _initAgoraEngine(souguuInfo.restSouguuNotification?.token ?? "");
        countdown.value = souguuInfo.restSouguuNotification!.callStartTime.difference((await TimeUtil.getOfficialTime())).inSeconds;
        status.value = 1;

        _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
          if (status.value > 1) {
            timer.cancel();
          }
          // if (souguuInfo.restSouguuNotification!.callStartTime < DateTime.now()) {
          var now = await TimeUtil.getOfficialTime();
          if (souguuInfo.restSouguuNotification?.callStartTime.compareTo(now) == -1) {
            status.value = 2;
          }
          countdown.value = souguuInfo.restSouguuNotification!.callStartTime.difference(now).inSeconds;
        });
      })();
      // #TODO 通話終了時にエンジンを破棄する, timerを破棄
      return () {
        //_engine.destroy();
        _timer?.cancel();
      };
    }, []);

    // 通話開始時に通話に参加
    useEffect(() {
      if (status.value == 2) {
        logger.i("通話開始");
        debugPrint(souguuInfo.restSouguuNotification!.token);
        var task = () async {
          var now = await TimeUtil.getOfficialTime();
          callCountdown.value = souguuInfo.restSouguuNotification!.callEndTime.difference(now).inSeconds;
          _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (callCountdown.value == 0) {
              status.value = 3;
              return;
            }
            callCountdown.value = callCountdown.value - 1;
          });
        }();
        _engine.joinChannel(
            token: souguuInfo.restSouguuNotification!.token,
            channelId: souguuInfo.restSouguuNotification!.callId.toString(),
            uid: userState!.id,
            options: const ChannelMediaOptions(
              clientRoleType: ClientRoleType.clientRoleBroadcaster,
            ));
        Future.wait([task]);
      }
      return null;
    }, [status.value]);

    Widget widget;
    switch (status.value) {
      case 0:
        widget = const CircularProgressIndicator();
        break;
      case 1:
        widget = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "通話まであと",
                style: TextStyle(fontSize: 35),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
                child: Text(
              "${countdown.value}秒",
              style: const TextStyle(fontSize: 32),
            ))
          ],
        );
        break;
      case 2:
        widget = Column(
          children: [
            const Center(
              child: Text(
                "通話中",
                style: TextStyle(fontSize: 40),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "通話終了まであと",
                style: TextStyle(fontSize: 35),
              ),
            ),
            Center(
              child: Text(
                "${callCountdown.value}秒",
                style: const TextStyle(fontSize: 32),
              ),
            )
          ],
        );
        break;
      default:
        widget = const Center(
          child: Text(
            "通話終了",
            style: TextStyle(fontSize: 40),
          ),
        );
    }

    return WithForegroundTask(
      child: Scaffold(
        appBar: AppBar(),
        body: widget,
      ),
    );
  }

  Future<void> _initAgoraEngine(String token) async {
    _engine = createAgoraRtcEngine();
    logger.d("appId: ${battariSetting.appIdAgora}");
    await _engine
        .initialize(RtcEngineContext(appId: battariSetting.appIdAgora, channelProfile: ChannelProfileType.channelProfileCommunication));
    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: ((err, msg) => logger.e("onError: $err, $msg")),
      onJoinChannelSuccess: (connection, elapsed) => debugPrint("onJoinChannelSuccess: ${connection.channelId}, $elapsed"),
      onUserJoined: (connection, remoteUid, elapsed) => debugPrint("onUserJoined: $connection, $remoteUid, $elapsed"),
      onUserOffline: (remoteUid, reason, a) => debugPrint("onUserOffline: $remoteUid, $reason"),
    ));
    await _engine.enableWebSdkInteroperability(true);
    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

  Future<void> _requestPermissionForAndroid() async {
    if (!Platform.isAndroid) {
      return;
    }

    // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
    // onNotificationPressed function to be called.
    //
    // When the notification is pressed while permission is denied,
    // the onNotificationPressed function is not called and the app opens.
    //
    // If you do not use the onNotificationPressed or launchApp function,
    // you do not need to write this code.
    if (!await FlutterForegroundTask.canDrawOverlays) {
      // This function requires `android.permission.SYSTEM_ALERT_WINDOW` permission.
      await FlutterForegroundTask.openSystemAlertWindowSettings();
    }

    // Android 12 or higher, there are restrictions on starting a foreground service.
    //
    // To restart the service on device reboot or unexpected problem, you need to allow below permission.
    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      // This function requires `android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` permission.
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }

    // Android 13 and higher, you need to allow notification permission to expose foreground service notification.
    final NotificationPermission notificationPermissionStatus = await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermissionStatus != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }
  }
}
