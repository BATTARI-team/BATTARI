import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 249, 231, 1),
        body: Padding(
          padding: const EdgeInsets.all(55.0),
          child: Center(
              //child: SvgPicture.asset("assets/titleLogo.svg"),
              child: Image.asset("assets/titleLogo.png")),
        ));
  }
}
