import 'package:battari/view/developer/developer_widgets.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DeveloperWidgets.loginedUserWidget(),
      ),
    );
  }
}
