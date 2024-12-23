import 'package:battari/service/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionDevelopperPage extends StatelessWidget {
  const PermissionDevelopperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, _) {
      return TextButton(
          onPressed: () async {
            await ref.read(permissionServiceProvider.notifier).init();
          },
          child: const Text("Get permission"));
    }));
  }
}
