import 'package:flutter/material.dart';

class BattariAppBar extends StatelessWidget implements PreferredSizeWidget {
  late final AppBar appBar;
  final bool needDrawer;
  BuildContext? context;

  BattariAppBar({super.key, this.needDrawer = true})
      : appBar = AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person_add_outlined,
                  size: 30,
                ),
              ),
            )
          ],
          elevation: 10,
          toolbarHeight: 70,
          leading: Builder(builder: (context) {
            return needDrawer ? IconButton(icon: const Icon(Icons.menu), onPressed: () => _onPressed(context)) : const SizedBox.shrink();
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
