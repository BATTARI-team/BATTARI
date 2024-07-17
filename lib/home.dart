import 'package:battari/added_friend.dart';
import 'package:battari/battari_config.dart';
import 'package:battari/notification_service.dart';
import 'package:battari/notification_view.dart';
import 'package:battari/profile_view.dart';
import 'package:battari/souguu_service.dart';
import 'package:battari/wait_for_call_view.dart';
import 'package:battari/websocket_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          notificationButton(context),
          Consumer(builder: (context, ref, _) {
            return IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await ref
                      .read(flutterLocalNotificationsPluginProvider)
                      .flutterLocalNotificationsPlugin
                      .show(
                          0,
                          'なになにさんから友達申請がきました',
                          '通知をタップして友達追加を行います',
                          payload: 'friend_add',
                          NotificationDetails(
                              android: AndroidNotificationDetails(
                                  'friend_add', '友達追加',
                                  importance: Importance.max,
                                  priority: Priority.high,
                                  showWhen: false)));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddedFriendView()));
                });
          }),
        ]),
        body: Column(
          children: [
            TextButton(onPressed: () {}, child: Text('FriendAddedView')),
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WaitForCall())),
              child: Text('wait_for_call_view'),
            ),
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileView(
                              userId: aiteUserId,
                              userName: aiteUserName,
                              userIconUrl: aiteIconUrl,
                              userDescription: aiteDescription,
                            ))),
                child: Text('profile')),
            Consumer(builder: (context, ref, _) {
              return TextButton(
                  child: Text("souguu"),
                  onPressed: () => ref.read(souguuServiceProvider).Souguu());
            }),
            LikeButton(
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.check,
                );
              },
            ),
            TextButton(
              child: Text("websocket"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WebSocketTest())),
            )
          ],
        ));
  }

  IconButton notificationButton(BuildContext context) {
    return IconButton(
        icon: Stack(
          children: [
            Icon(Icons.notifications),
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NotificationView()));
        });
  }
}
