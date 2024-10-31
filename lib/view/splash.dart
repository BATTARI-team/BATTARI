import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: init(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go('/first_page');
                });
                return SizedBox.shrink();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  // #TODO スプラッシュでログインとかする
  Future<void> init() async {}
}
