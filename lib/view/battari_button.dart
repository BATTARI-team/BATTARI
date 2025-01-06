import 'package:battari/constant/app_color.dart';
import 'package:battari/constant/app_size.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class BattariTextButton extends StatelessWidget {
  final Color backgrandColor;
  final Color textColor;
  final void Function() onpressed;
  final IconData icon;
  final String text;

  const BattariTextButton(
      {super.key,
      required this.backgrandColor,
      required this.icon,
      required this.onpressed,
      required this.textColor,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final appSize = AppSize(context);
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgrandColor,
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          maximumSize: Size(appSize.deviceWidth * 0.8, 45),
          minimumSize: Size(appSize.deviceWidth * 0.8, 45),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 5),
          BorderedText(
            strokeWidth: 2.0,
            strokeColor: AppColor.text.gray,
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
