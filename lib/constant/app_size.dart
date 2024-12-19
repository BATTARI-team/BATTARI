import 'package:flutter/material.dart';

class AppSize {
  final double deviceWidth;
  final double deviceHeight;

  AppSize(BuildContext context)
      : deviceWidth = MediaQuery.of(context).size.width,
        deviceHeight = MediaQuery.of(context).size.height;

  double get widgetWidth => deviceWidth * 0.9;
}

class FontSize {
  /// 注意文
  static const double annotation = 12;

  /// 本文
  static const double body = 20;

  /// ラベル内
  static const double label = 18;

  /// 大見出し
  static const double heading = 20;

  /// 副見出し
  static const double subheading = 18;

  /// ステータス表示
  static const double status = 28;
}
