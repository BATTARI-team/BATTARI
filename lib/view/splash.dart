import 'package:battari/repository/user_repository.dart';
import 'package:battari/model/state/user_state.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends HookConsumerWidget {
  const Splash({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Splash build");
    init(context, ref);
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Future<void> init(BuildContext context, WidgetRef ref) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    var sharedPreferences = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    // この関数が終わらないと遷移しないため
    ProviderScope.containerOf(context).updateOverrides([
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ]);
    UserState? userState = await ref.read(userSharedPreferencesRepositoryProvider).get();
    debugPrint("done");
    if (userState != null) {
      var token = await ref.read(userViewModelProvider.notifier).refreshToken(userState.id, userState.refreshToken);
      var isCall = await ref.read(souguuServiceInfoProvider.notifier).init();

      if (token.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/login');
        });
        return;
      } else {
        debugPrint("isCall: $isCall");
        if (isCall) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/call');
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home');
          });
        }
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
