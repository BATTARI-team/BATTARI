import 'package:battari/components/app_bar.dart';
import 'package:battari/components/drawer.dart';
import 'package:battari/constant/app_color.dart';
import 'package:battari/constant/app_size.dart';
import 'package:battari/logger.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/view/developer/developer_widgets.dart';
import 'package:battari/view/online_widget.dart';
import 'package:battari/view/usercard.dart';
import 'package:battari/view_model/is_home_view_model.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyAppBar extends PreferredSize {
  const MyAppBar(
      {super.key, required super.preferredSize, required super.child});
}

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var isHome = ref.watch(isHomeViewModelProvider).maybeWhen(
          data: (data) => data,
          orElse: () => false,
        );
    return Scaffold(
      drawer: const BattariDrawer(),
      appBar: BattariAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          context.push('/developer');
        }),
        child: const Text("developer page"),
      ),
      body: Center(
        child: loginedUserWidget(context, isHome),
      ),
    );
  }

  static loginedUserWidget(BuildContext context, bool isHome) {
    final appSize = AppSize(context); // AppSize インスタンスを作成

    return Consumer(builder: (context, ref, _) {
      var data = ref.watch(userViewModelProvider);

      if (data == null) {
        return const CircularProgressIndicator(
          color: Colors.red,
        );
      }
      var isHome = ref.watch(isHomeViewModelProvider).maybeWhen(
            orElse: () => false,
            data: (data) => data,
          );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: userCard(
            username: data.name,
            userid: data.userId,
            cardcolor: AppColor.brand.secondary,
            isHome: isHome,
          )),
        ],
      );
    });
  }
}
