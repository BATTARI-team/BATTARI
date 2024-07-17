import 'package:battari/battari_config.dart';
import 'package:battari/battari_widgets.dart';
import 'package:battari/souguu_service.dart';
import 'package:battari/wait_for_call_notifier_provider.dart';
import 'package:battari/wait_for_call_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CountDownWidget extends ConsumerStatefulWidget {
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
    if (max == 0) {
      max = seconds;
    } else {
      max = max * divider;
    }
    debugPrint("max: $max");
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
  ConsumerState<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends ConsumerState<CountDownWidget> {
  @override
  Widget build(BuildContext context) {
    final int second = widget.seconds ~/ widget.divider;

    return Column(
      children: [
        BattariHeader(title: "通話まで・・"),
        //Consumer(builder: (context, ref, _) {
        //  final state = ref.read(countdownNotifierProvider);
        //  debugPrint("countdown: $state");
        //  return Container(
        //    decoration: BoxDecoration(color: Colors.white),
        //    width: double.infinity,
        //    child: Card(
        //      color: Colors.transparent,
        //      elevation: 0,
        //      child: CountDownWidget(
        //        ref.read(countdownNotifierProvider).seconds,
        //        max: ref.read(countdownNotifierProvider).max,
        //        isNeedInfence: true,
        //      ),
        //    ),
        //  );
        //}),
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
    debugPrint("initState");
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
    //ref.read(countdownNotifierProvider.notifier).startCountdown(countdown);
    debugPrint("_startcountdown: ${widget.seconds}");
    widget.progress = widget.seconds / widget.max;
    //ProviderScope.containerOf(context).watch(isTalkingProvider).debugPhysicalSizeOverride = true;

    //#TODO ここでisTalkingをtrueにする
    if (widget.seconds == 0) {
      //ref.read(waitForCallNotifierProvider.notifier).startCall();
    }
    while (widget.seconds > 0) {
      await Future.delayed(Duration(milliseconds: 1000 ~/ widget.divider));

      updateSeconds();
    }
  }
}

//class CountdownWidget extends ConsumerWidget {
//  const CountdownWidget({
//    super.key,
//  });
//
//  @override
//  Widget build(BuildContext context, ref) {
//    return Column(
//      children: [],
//    );
//  }
//}
