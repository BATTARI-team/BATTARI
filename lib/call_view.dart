import 'package:battari/battari_widgets.dart';
import 'package:flutter/material.dart';

const appBarHeight = 40;

class CallView extends StatelessWidget {
  const CallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: appBarHeight.toDouble(),
        ),
        BattariHeader(title: "")
      ],
    ));
  }
}
