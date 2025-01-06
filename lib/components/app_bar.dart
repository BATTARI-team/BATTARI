import 'package:flutter/material.dart';

class BattariAppBar extends StatelessWidget implements PreferredSizeWidget {
  late final AppBar appBar;
  BuildContext? context;

  BattariAppBar({super.key})
      : appBar = AppBar(
          elevation: 10,
          toolbarHeight: 70,
          leading: Builder(builder: (context) {
            return IconButton(icon: const Icon(Icons.menu), onPressed: () => _onPressed(context));
          }),
          title: Image.asset("assets/images/titleLogo.png", height: 50),
          shape: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        );

  static void _onPressed(BuildContext? context) {
    if (context == null) return;
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return appBar;
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
