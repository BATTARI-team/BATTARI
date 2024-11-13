import 'package:battari/repository/user_repository.dart';
import 'package:battari/state/user_state.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Splash extends HookConsumerWidget {
  const Splash({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      init(context, ref);
      return null;
    });
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Future<void> init(BuildContext context, WidgetRef ref) async {
    UserState? userState = await ref.read(userSharedPreferencesRepositoryProvider).get();
    debugPrint("done");
    if (userState != null) {
      var token = await ref.read(userViewModelProvider.notifier).refreshToken(userState.id, userState.refreshToken);
      if (token.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/login');
        });
        return;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/home');
        });
        return;
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return;
    }
  }
}
