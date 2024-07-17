import 'package:battari/battari_widgets.dart';
import 'package:battari/call_view.dart';
import 'package:battari/const_value.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ProfileView extends StatefulWidget {
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
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isFriend = false;

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
                    Text("@${widget.userId}", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text(widget.userName,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    Text(widget.userDescription,
                        style: TextStyle(fontSize: 15)),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )),
            ),
            if (!isFriend)
              Container(
                constraints: BoxConstraints(minWidth: double.infinity),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Column(children: [
                      Text(
                        "友達申請が来ています",
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LikeButton(
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.check,
                              );
                            },
                            onTap: (bool isLiked) async {
                              //setState(() async {
                              //  await Future.delayed(
                              //      const Duration(milliseconds: 2000));
                              //  isFriend = true;
                              //});
                              () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 1000));
                                setState(() {
                                  isFriend = true;
                                });
                              }();
                              return Future.value(true);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                isFriend = false;
                              });
                            },
                          )
                        ],
                      )
                    ]),
                  ),
                ),
              ),
          ],
        ),
      ),
    ));
  }
}
