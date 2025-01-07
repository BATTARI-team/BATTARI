import 'package:battari/constant/app_color.dart';
import 'package:flutter/material.dart';

class offlineWidget extends StatelessWidget {
  final double width;
  final double height;
  const offlineWidget({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.ui.white, width: 2),
          shape: BoxShape.circle,
          color: Colors.grey),
    );
  }
}