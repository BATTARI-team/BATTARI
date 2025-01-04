import 'package:battari/constant/app_color.dart';
import 'package:battari/view/online_widget.dart';
import 'package:flutter/material.dart';
import 'package:battari/constant/app_size.dart';

class userCard extends StatelessWidget {
  final String username;
  final String userid;
  final bool isHome;
  final Color cardcolor;

  const userCard({
    super.key,
    required this.username,
    required this.userid,
    required this.isHome,
    required this.cardcolor,
  });

  @override
  Widget build(BuildContext context) {
    // AppSize をコンテキストから初期化
    final appSize = AppSize(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: AppColor.ui.darkborder,
        ),
        borderRadius: BorderRadius.circular(20),
        color: cardcolor,
      ),
      width: appSize.widgetWidth, // widgetWidthを使用
      height: 243,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: appSize.deviceWidth * 0.2,
                  height: appSize.deviceHeight * 0.1,
                  decoration: BoxDecoration(
                    boxShadow: const [
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
              username,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: AppColor.text.darkgray,
              ),
            ),
            Text("@$userid"),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                onlineWidget(
                  height: 20,
                  width: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  '誰かと遭遇するかも...!',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: AppColor.text.darkgray,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 20,
                ),
                const Text(
                  'スマートフォンを使用している',
                  style: TextStyle(fontSize: 11),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.check,
                  color: isHome ? Colors.green : Colors.grey,
                  size: 20,
                ),
                const Text(
                  '位置情報が自宅',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
