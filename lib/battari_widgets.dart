import 'package:flutter/material.dart';

const HeaderStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 25);

class BattariHeader extends StatelessWidget {
  final String title;
  final TextStyle headerStyle;
  final String? subTitle;

  const BattariHeader(
      {super.key,
      required this.title,
      this.headerStyle = HeaderStyle,
      this.subTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Text(title, textAlign: TextAlign.start, style: headerStyle),
            SizedBox(
              width: 10,
            ),
            if (subTitle != null) BattariSubHeader(title: subTitle!),
          ],
        ));
  }
}

class BattariSubHeader extends StatelessWidget {
  final String title;
  const BattariSubHeader({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20),
    );
  }
}

class UserIcon extends StatelessWidget {
  final double height;
  final double borderRadius;
  final String iconurl;
  const UserIcon(
      {super.key,
      this.height = 100,
      this.borderRadius = 100,
      this.iconurl = "https://avatars.githubusercontent.com/u/44548782?v=4"});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(iconurl),
      ),
    );
  }
}
