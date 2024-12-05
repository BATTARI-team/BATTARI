import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SettingHomeView extends StatefulWidget {
  @override
  State<SettingHomeView> createState() => _SettingHomeViewState();
}

class _SettingHomeViewState extends State<SettingHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('Setting Home View'),
          const Text("please set allow location service(always)"),
          TextButton(onPressed: () async {
            var isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
            debugPrint(isLocationServiceEnabled.toString());
            if(isLocationServiceEnabled) {
              var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
              debugPrint(position.toString());
            }

          },child:const Text(
            "こを自宅として登録する"),)
        ],
      )
  );
  }
}
