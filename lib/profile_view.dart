import 'package:battari/battari_widgets.dart';
import 'package:battari/call_view.dart';
import 'package:battari/const_value.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userIconUrl,
      required this.userDescription});

  final String userId;
  final String userName;
  final String userIconUrl;
  final String userDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(basicPaddingSize),
        child: Column(
          children: [
            SizedBox(height: appBarHeight.toDouble()),
            Container(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: Card(
                  child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    UserIcon(),
                    SizedBox(height: 5),
                    Text("@$userId", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text(userName,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600)),
                    Text(userDescription, style: TextStyle(fontSize: 15)),
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    ));
  }
}
