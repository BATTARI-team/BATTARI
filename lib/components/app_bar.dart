import 'package:flutter/material.dart';

class BattariAppBar extends StatelessWidget implements PreferredSizeWidget {
  late final AppBar appBar;

  BattariAppBar({super.key})
      : appBar = AppBar(
          elevation: 10,
          toolbarHeight: 70,
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          title: Image.asset("assets/images/titleLogo.png", height: 50),
          shape: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return appBar;
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
