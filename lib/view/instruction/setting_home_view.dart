import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class SettingHomeView extends StatefulWidget {
  SettingHomeView({super.key});

  @override
  State<SettingHomeView> createState() => _SettingHomeViewState();
  double latitude = 0;
  double longitude = 0;
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
            TextButton(
              onPressed: () async {
                var isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
                debugPrint(isLocationServiceEnabled.toString());
                if (isLocationServiceEnabled) {
                  var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  debugPrint(position.toString());
                  setState(() {
                    widget.longitude = position.longitude;
                    widget.latitude = position.latitude;
                  });
                }
              },
              child: const Text("こを自宅として登録する"),
            ),
            if (widget.latitude != 0 && widget.longitude != 0)
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(widget.latitude, widget.longitude),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(widget.latitude, widget.longitude),
                          child: const Icon(Icons.home),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            else
              Container(),
            if (widget.latitude != 0 && widget.longitude != 0)
              Consumer(builder: (context, ref, _) {
                return TextButton(
                    child: const Text("続ける"),
                    onPressed: () async {
                      ref.read(userViewModelProvider.notifier).setHome(widget.latitude, widget.longitude);
                      if (await FlutterForegroundTask.isRunningService) FlutterForegroundTask.restartService();
                      if (context.mounted) {
                        Navigator.pop(context, [widget.latitude, widget.longitude]);
                      }
                    });
              })
          ],
        ));
  }
}
