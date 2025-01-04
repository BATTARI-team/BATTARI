import 'package:battari/constant/app_color.dart';
import 'package:battari/constant/app_size.dart';
import 'package:battari/logger.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:battari/view/developer/developer_widgets.dart';
import 'package:battari/view/online_widget.dart';
import 'package:battari/view_model/is_home_view_model.dart';
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
    var isHome = ref.watch(isHomeViewModelProvider).maybeWhen(
          data: (data) => data,
          orElse: () => false,
        );
    return Scaffold(
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: AppColor.ui.darkborder,
                ),
                borderRadius: BorderRadius.circular(20),
                color: AppColor.brand.secondary,
              ),
              width: appSize.widgetWidth, // インスタンス経由で widgetWidth にアクセス
              height: 243,
              child: Center(
                  child: Column(
                children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        width: appSize.deviceWidth * 0.2,
                        height: appSize.deviceHeight * 0.1,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0.5,
                              blurRadius: 8,
                              offset: Offset(4, 4),
                            ),
                          ],
                          border: Border.all(color: AppColor.ui.white),
                          color: AppColor.ui.a,
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/defaultIcon.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 67,
                        left: 60,
                        child: onlineWidget(width: 22, height: 22),
                      ),
                    ],
                  ),
                  SizedBox(height: appSize.deviceHeight * 0.01),
                  Text(
                    data.name,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: AppColor.text.darkgray),
                  ),
                  Text("@${data.userId}"),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      onlineWidget(
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '誰かと遭遇するかも...!',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColor.text.darkgray),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 20,
                      ),
                      Text(
                        'スマートフォンを使用している',
                        style: TextStyle(fontSize: 11),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.check,
                        color: isHome ? Colors.green : Colors.grey,
                        size: 20,
                      ),
                      Text(
                        '位置情報が自宅',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  )
                ],
              )),
            ),
          ),
        ],
      );
    });
  }
}
