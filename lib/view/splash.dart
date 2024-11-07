import 'package:battari/repository/user_repository.dart';
import 'package:battari/state/user_state.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Splash extends HookConsumerWidget {
  Splash({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return Scaffold(
    //     body: FutureBuilder(
    //         future: init(context),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.done) {
    //             WidgetsBinding.instance.addPostFrameCallback((_) {
    //               if (isLogin.value) {
    //                 context.go('/home');
    //               } else {
    //                 context.go('/first_page');
    //               }
    //             });
    //             return const SizedBox.shrink();
    //           } else {
    //             return const Center(child: CircularProgressIndicator());
    //           }
    //         }));
    useEffect(() {
      init(context, ref);
      return null;
    });
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Future<void> init(BuildContext context, WidgetRef ref) async {
    UserState? userState = await ref.read(userSharedPreferencesRepositoryProvider).get();
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
    }
  }
}
