import 'package:battari/battari_confg.dart';
import 'package:battari/battari_widgets.dart';
import 'package:battari/call_view.dart';
import 'package:battari/call_widget.dart';
import 'package:battari/const_value.dart';
import 'package:battari/count_down_widget.dart';
import 'package:battari/wait_for_call_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void startCall() {}

class KeywordsWidget extends StatelessWidget {
  final List<String> keywords;
  const KeywordsWidget({super.key, required this.keywords});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Row(
              children: const [
                Text("最後の通話", style: HeaderStyle),
                SizedBox(
                  width: 10,
                ),
                BattariSubHeader(title: "5月24日"),
              ],
            )),
        Container(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "キーワード",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: keywords.map((keyword) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Chip(
                        label: Text(keyword),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: unused_element
class _CancelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Flexible(
              child: TextFormField(
                  decoration: InputDecoration(
            hintText: "キャンセルの理由を伝える",
            suffixIcon: IconButton(icon: Icon(Icons.send), onPressed: () {}),
          ))),
        ],
      );
}

class _LastTalkingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BattariHeader(
        title: "相手",
        subTitle: "@takuto1127",
      ),
      Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Card(
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserIcon(),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    aiteUserName,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  souguuRiyuu,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 70),
      KeywordsWidget(keywords: keywords),
    ]);
  }
}

class WaitForCall extends StatefulWidget {
  const WaitForCall({super.key});

  @override
  State<WaitForCall> createState() => _WaitForCallState();
}

class _WaitForCallState extends State<WaitForCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(basicPaddingSize),
        child: Consumer(builder: (context, ref, _) {
          return Column(
            children: [
              SizedBox(
                height: appBarHeight.toDouble(),
              ),
              SizedBox(height: 30),
              if (!ref.watch(waitForCallNotifierProvider)) CountdownWidget(),
              _LastTalkingWidget(),
              //if (!ref.watch(isTalkingProvider)) _CancelWidget(),
              SizedBox(
                height: 100,
              ),
              if (ref.watch(waitForCallNotifierProvider)) CallWidget(),
            ],
          );
        }),
      ),
    ));
  }
}
