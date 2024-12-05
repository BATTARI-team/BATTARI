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
          TextButton(onPressed: () async {
            var currentLocation = await Geolocator.requestPermission();
            debugPrint(currentLocation.toString());
          },child:const Text(
            "こを自宅として登録する"),)
        ],
      )
  );
  }
}
