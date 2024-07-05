import 'package:flutter/material.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';

class AppUsageTime extends StatefulWidget {
  const AppUsageTime({super.key});

  @override
  _AppUsageState createState() => _AppUsageState();
}

class _AppUsageState extends State<AppUsageTime> {
  List<EventUsageInfo> events = [];
  Map<String?, NetworkInfo?> _netInfoMap = Map();

  @override
  void initState() {
    super.initState();

    initUsage();
  }

  Future<void> initUsage() async {
    try {
      UsageStats.grantUsagePermission();

      DateTime endDate = new DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 1));

      List<EventUsageInfo> queryEvents =
          await UsageStats.queryEvents(startDate, endDate);
      List<NetworkInfo> networkInfos = await UsageStats.queryNetworkUsageStats(
        startDate,
        endDate,
        networkType: NetworkType.all,
      );

      Map<String?, NetworkInfo?> netInfoMap = Map.fromIterable(networkInfos,
          key: (v) => v.packageName, value: (v) => v);

      List<UsageInfo> t = await UsageStats.queryUsageStats(startDate, endDate);

      for (var i in t) {
        if (double.parse(i.totalTimeInForeground!) > 0) {
          print(
              DateTime.fromMillisecondsSinceEpoch(int.parse(i.firstTimeStamp!))
                  .toIso8601String());

          print(DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeStamp!))
              .toIso8601String());

          print(i.packageName);
          print(DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeUsed!))
              .toIso8601String());
          print(int.parse(i.totalTimeInForeground!) / 1000 / 60);

          print('-----\n');
        }
      }
      setState(() {
        events = queryEvents.reversed.toList();
        _netInfoMap = netInfoMap;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<EventUsageInfo> filteredEvents = events
        .where((event) => event.eventType == '1' || event.eventType == '2')
        .toList();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Usage Stats"), actions: const [
          IconButton(
            onPressed: UsageStats.grantUsagePermission,
            icon: Icon(Icons.settings),
          )
        ]),
        body: RefreshIndicator(
          onRefresh: initUsage,
          child: ListView.separated(
            itemBuilder: (context, index) {
              var event = filteredEvents[index];
              var networkInfo = _netInfoMap[event.packageName];
              return ListTile(
                title: Text(event.packageName!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Last time used: ${DateTime.fromMillisecondsSinceEpoch(int.parse(events[index].timeStamp!)).toIso8601String()}"),
                    networkInfo == null
                        ? const Text("Unknown network usage")
                        : Text("Received bytes: ${networkInfo.rxTotalBytes}\n"
                            "Transfered bytes : ${networkInfo.txTotalBytes}"),
                  ],
                ),
                trailing: Text(event.eventType!),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: filteredEvents.length,
          ),
        ),
      ),
    );
  }
}
