import 'package:battari/call_view.dart';
import 'package:flutter/material.dart';

class WaitForCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: appBarHeight.toDouble(),
        ),
        _lastTalking(),
				_countdownUntilCall(),
      ],
    ));
  }

  Widget _lastTalking() {
    return const Column(children: [
      Text('Waiting for call...'),
    ]);
  }

  Widget _countdownUntilCall() {
		return const Column(children: [
			
		]);
		}

	
}

class CountDownWidget extends StatelessWidget{
	final int seconds;
	final Function onCountDownFinish;

  const CountDownWidget({super.key, required this.seconds, this.onCountDownFinish = });

	@override	
	Widget build(BuildContext context){
		return Text('$seconds');
	}
}
