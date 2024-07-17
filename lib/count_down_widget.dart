import 'package:battari/battari_widgets.dart';
import 'package:battari/wait_for_call_view.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void updateSeconds() {
    setState(() {
      widget.seconds--;
      widget.progress = widget.seconds / widget.max;
    });
  }

  Future<void> _startCountdown() async {
    widget.progress = widget.seconds / widget.max;
    //ProviderScope.containerOf(context).watch(isTalkingProvider).debugPhysicalSizeOverride = true;

    //#TODO ここでisTalkingをtrueにする
    if (widget.seconds == 0) {}
    while (widget.seconds > 0) {
      await Future.delayed(Duration(milliseconds: 1000 ~/ widget.divider));
      updateSeconds();
    }
  }
}

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
