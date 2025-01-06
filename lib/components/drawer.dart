import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BattariDrawer extends StatelessWidget {
  const BattariDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              context.pop();
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              context.pop();
            },
          ),
        ],
      ),
    ));
  }
}
