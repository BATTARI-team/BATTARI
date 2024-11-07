import 'package:battari/view/developer/developer_widgets.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context).pushNamed("/developer");
        }),
        child: const Text("developer page"),
      ),
      body: Center(
        child: DeveloperWidgets.loginedUserWidget(),
      ),
    );
  }
}
