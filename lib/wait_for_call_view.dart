import 'package:battari/call_view.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WaitForCall extends StatelessWidget {
  const WaitForCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: [
          SizedBox(
            height: appBarHeight.toDouble(),
          ),
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
          _LastTalkingWidget(),
        ],
      ),
    ));
  }
}

const headerStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 25);

class _LastTalkingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              child: Text("@takutakutakutaku",
                  textAlign: TextAlign.start, style: headerStyle)),
          Container(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                            "https://avatars.githubusercontent.com/u/44548782?v=4"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text("田中太郎"),
                    ),
                    Text("Instagramを未定た"),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          keywordsWidget(keywords: ["Flutter", "Dart", "Firebase"]),
        ],
      ),
    );
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
                Text("5月24日", style: headerStyle),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "最後の通話",
                  style: TextStyle(fontSize: 20),
                )
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
