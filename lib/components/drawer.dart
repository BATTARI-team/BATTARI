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
            title: const Text('🏠　自宅の設定をする'),
            onTap: () {
              context.push('/settings_home');
            },
          ),
          ListTile(title: const Text("📄　プライバシーポリシー"), onTap: () {}),
          ListTile(
              title: const Text("🛠️　開発者用設定"),
              onTap: () {
                context.push('/developer');
              })
        ],
      ),
    ));
  }
}
