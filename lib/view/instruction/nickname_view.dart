import 'package:battari/view/instruction/register_view.dart';
import 'package:flutter/material.dart';

class NicknameView extends StatelessWidget {
  const NicknameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [BattariUserFormWidgets.BattariNicknameField()],
      ),
    );
  }
}
