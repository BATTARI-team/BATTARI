import 'package:battari/constant/app_color.dart';
import 'package:battari/constant/app_size.dart';
import 'package:battari/logger.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/view/developer/developer_widgets.dart';
import 'package:battari/view/online_widget.dart';
import 'package:battari/view/usercard.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // FlutterForegroundTask.addTaskDataCallback((data) {
    //   logger.d("foreground task data: $data");
    //   if (context.mounted) {
    //     ref.read(souguuServiceProvider.notifier).dealNotification(data.toString(), true);
    //   }
    //   // ref.read(souguuServiceProvider.notifier).disconnectWebsocket();
    // });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          context.push('/developer');
        }),
        child: const Text("developer page"),
      ),
      body: Center(
        child: loginedUserWidget(context, false),
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: userCard(
            username: data.name,
            userid: data.userId,
            cardcolor: AppColor.brand.secondary,
            isHome: true,
          )),
        ],
      );
    });
  }
}
