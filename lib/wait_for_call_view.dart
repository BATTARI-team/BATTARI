import 'package:battari/battari_config.dart';
import 'package:battari/battari_widgets.dart';
import 'package:battari/call_view.dart';
import 'package:battari/call_widget.dart';
import 'package:battari/const_value.dart';
import 'package:battari/count_down_widget.dart';
import 'package:battari/souguu_service.dart';
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
                Row(
                  children: [
                    Text("前回の遭遇", style: HeaderStyle),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                BattariSubHeader(title: "5月24日"),
              ],
            )),
        Container(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
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
                        backgroundColor: Color.fromRGBO(255, 211, 78, 0.6),
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

class StrokedText extends StatelessWidget {
  const StrokedText(
    this.text, {
    this.color,
    this.strokeColor,
    this.fontSize,
    this.strokeSize,
    super.key,
  });

  final String text;
  final Color? color;
  final Color? strokeColor;
  final double? fontSize;
  final double? strokeSize;

  @override
  Widget build(BuildContext context) {
    final fontSize = this.fontSize ??
        Theme.of(context).textTheme.bodyMedium?.fontSize ??
        16.0;

    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeSize ?? 2
              ..color = color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        // Solid text as fill.
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: strokeColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}

class _LastTalkingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //BattariHeader(
      //  title: "相手",
      //  subTitle: "@takuto1127",
      //),
      Container(
        constraints: BoxConstraints(minWidth: double.infinity),
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
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    souguuRiyuu,
                    style: TextStyle(fontSize: 20),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Stack(
                        children: [
                          //StrokedText(
                          //  "BATTARI",
                          //  color: Colors.black,
                          //  fontSize: 20,
                          //),
                          Text("BATTARI",
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 20))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 35),
      Divider(),
      SizedBox(height: 35),
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
    Widget bottomBar;
    return Consumer(builder: (context, ref, _) {
      if (ref.watch(waitForCallNotifierProvider)) {
        bottomBar = CallWidget();
      } else {
        bottomBar = SizedBox.shrink();
      }
      return Scaffold(
          backgroundColor: Color.fromRGBO(255, 249, 231, 1),
          bottomNavigationBar: bottomBar,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(basicPaddingSize),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: appBarHeight.toDouble(),
                          ),
                          SizedBox(height: 30),
                          if (!ref.watch(waitForCallNotifierProvider))
                            CountDownWidget(
                                ref.read(countdownNotifierProvider).seconds,
                                max: ref.read(countdownNotifierProvider).max),
                          _LastTalkingWidget(),
                          //if (!ref.watch(isTalkingProvider)) _CancelWidget(),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
