import 'package:battari/battari_widgets.dart';
import 'package:battari/call_view.dart';
import 'package:battari/const_value.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WaitForCall extends StatefulWidget {
  const WaitForCall({super.key});

  @override
  State<WaitForCall> createState() => _WaitForCallState();
}

class _WaitForCallState extends State<WaitForCall> {
  bool isTalking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(basicPaddingSize),
        child: Column(
          children: [
            SizedBox(
              height: appBarHeight.toDouble(),
            ),
            if (!isTalking) CountdownWidget(),
            _LastTalkingWidget(),
            TextButton(
                child: Text("通話画面トグル"),
                onPressed: () {
                  setState(() => isTalking = !isTalking);
                }),
            if (!isTalking) _CancelWidget(),
          ],
        ),
      ),
    ));
  }
}

void startCall() {}

class CountdownWidget extends StatelessWidget {
  const CountdownWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BattariHeader(title: "通話まで・・"),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          width: double.infinity,
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: CountDownWidget(
              20,
              isNeedInfence: true,
            ),
          ),
        ),
      ],
    );
  }
}

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
        subTitle: "@takutaktuaktau",
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
                  child: Text("田中太郎"),
                ),
                Text("Instagramを未定た"),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      keywordsWidget(keywords: ["Flutter", "Dart", "Firebase"]),
    ]);
  }
}

class keywordsWidget extends StatelessWidget {
  final List<String> keywords;
  const keywordsWidget({super.key, required this.keywords});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Row(
              children: [
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

class CountDownWidget extends StatefulWidget {
  late int seconds;
  double progress = 0.0;
  late int max;
  double circularRadius;
  double lineWidth;
  int divider = 10;
  final bool isNeedInfence;

  CountDownWidget(this.seconds,
      {super.key,
      this.max = 0,
      this.circularRadius = 100,
      this.lineWidth = 15,
      this.divider = 10,
      this.isNeedInfence = false}) {
    seconds *= divider;
    max = seconds;
    const par = 30;
    if (isNeedInfence) {
      // ここで推論を行う
      if (max > par) {
        this.divider = 10;
      } else
        this.divider = (par / max).toInt() + 10;
      debugPrint("divider: $divider");
    }
  }

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  @override
  Widget build(BuildContext context) {
    final int second = widget.seconds ~/ widget.divider;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            lineWidth: widget.lineWidth,
            radius: widget.circularRadius,
            percent: widget.progress,
            center: Text("$second",
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.w500)),
            backgroundColor: const Color(0xFFEAE7E5),
          ),
          //child: LinearProgressIndicator(
          //  borderRadius: BorderRadius.circular(10),
          //  minHeight: 10,
          //  value: widget.progress,
          //  backgroundColor: Colors.grey,
          //),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  Future<void> _startCountdown() async {
    widget.progress = widget.seconds / widget.max;

    while (widget.seconds > 0) {
      await Future.delayed(Duration(milliseconds: 1000 ~/ widget.divider));
      updateSeconds();
    }
  }

  void updateSeconds() {
    setState(() {
      widget.seconds--;
      widget.progress = widget.seconds / widget.max;
    });
  }
}
