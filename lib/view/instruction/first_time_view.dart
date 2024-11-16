import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirstTimeView extends StatelessWidget {
  const FirstTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/register'),
              child: Container(
                width: 200,
                height: 50,
                decoration: ShapeDecoration(shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16 * 2.3529))),
                child: const Text("さっそくはじめる"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => context.push('/login'),
              child: Container(
                width: 200,
                height: 50,
                decoration: ShapeDecoration(shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16 * 2.3529))),
                child: const Text("ログインする"),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
