import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';

class AppUsageTime extends StatefulWidget {
  @override
  _AppUsageState createState() => _AppUsageState();
}

class _AppUsageState extends State<AppUsageTime> {
  List<EventUsageInfo> events = [];
  Map<String?, NetworkInfo?> _netInfoMap = Map();

  @override
  State<_AppUsageTime> createState() => _AppUsageState();
}

class _AppUsageState extends State<_AppUsageTime> {
  static const platform = MethodChannel('com.example.app/usage');

  String _usageTime = 'Unknown';

  Future<void> _getUsageTime() async {
    String usageTime;
    try {
      final int result = await platform.invokeMethod('getUsageTime');
      usageTime = 'App usage time: $result minutes';
    } on PlatformException catch (e) {
      usageTime = "Failed to get usage time: '${e.message}'.";
    }
    setState(() {
      _usageTime = usageTime;
    });
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
      this.setState(() {
        events = queryEvents.reversed.toList();
        _netInfoMap = netInfoMap;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your App Usage Time is:',
            ),
            Text(
              _usageTime,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUsageTime,
        tooltip: 'Get Usage Time',
        child: const Icon(Icons.update),
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Usage Stats"), actions: [
          IconButton(
            onPressed: UsageStats.grantUsagePermission,
            icon: Icon(Icons.settings),
          )
        ]),
        body: Container(
          child: RefreshIndicator(
            onRefresh: initUsage,
            child: ListView.separated(
              itemBuilder: (context, index) {
                var event = events[index];
                var networkInfo = _netInfoMap[event.packageName];
                return ListTile(
                  title: Text(events[index].packageName!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Last time used: ${DateTime.fromMillisecondsSinceEpoch(int.parse(events[index].timeStamp!)).toIso8601String()}"),
                      networkInfo == null
                          ? Text("Unknown network usage")
                          : Text("Received bytes: ${networkInfo.rxTotalBytes}\n" +
                              "Transfered bytes : ${networkInfo.txTotalBytes}"),
                    ],
                  ),
                  trailing: Text(events[index].eventType!),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: events.length,
            ),
          ),
        ),
      ),
    );
  }
}
