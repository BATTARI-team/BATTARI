import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:battari/main.dart';
import 'package:flutter/material.dart';

class CallService {
  late RtcEngine _engine;
  Future<void> initCall(String agoraToken, String channelId, int uId) async {
    debugPrint("initAgoraCalling");
    await _initAgoraEngine();
    await _engine.setDefaultAudioRouteToSpeakerphone(true);
    debugPrint("initAgoraCalling");
    await _engine.joinChannel(
        token: agoraToken,
        channelId: channelId,
        uid: uId,
        // Set the user role as host
        // To set the user role to audience, change clientRoleBroadcaster to clientRoleAudience
        options: const ChannelMediaOptions(clientRoleType: ClientRoleType.clientRoleBroadcaster));
  }

  Future<void> _initAgoraEngine() async {
    _engine = createAgoraRtcEngineEx();
    await _engine
        .initialize(RtcEngineContext(appId: battariSetting.appIdAgora, channelProfile: ChannelProfileType.channelProfileCommunication));
    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (err, msg) => debugPrint("エラーが発生したでー${err.toString()}"),
      onJoinChannelSuccess: (connection, elapsed) => debugPrint("成功したでー${connection.toString()}"),
      onUserJoined: (connection, remoteUid, elapsed) => debugPrint("誰か来たでー${connection.toString()}"),
      onUserOffline: (connection, remoteUid, reason) => debugPrint(connection.localUid.toString()),
    ));
    await _engine.enableWebSdkInteroperability(true);
    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    // await _engine.setAudioProfile(
    //   profile: AudioProfileType.audioProfileDefault,
    //   scenario: AudioScenarioType.audioScenarioDefault,
    // );
  }
}
