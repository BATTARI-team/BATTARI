import 'package:flutter/material.dart';

class FirstTimeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/second_page');
          },
          child: const Text('Go to Second Page'),
        ),
      ),
    );
  }
}
