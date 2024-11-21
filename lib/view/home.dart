import 'package:battari/view/developer/developer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          context.push('/developer');
        }),
        child: const Text("developer page"),
      ),
      body: Center(
        child: DeveloperWidgets.loginedUserWidget(),
      ),
    );
  }
}
