// 通話待ちまたは通話画面で，相手に通話をキャンセルされた時の画面(ねんのため)
import 'package:flutter/material.dart';

class CancelCallPage extends StatelessWidget {
  const CancelCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('通話をキャンセルされました'),
      ),
    );
  }
}
