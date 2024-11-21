import 'package:flutter/material.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';

class AppUsageTime extends StatefulWidget {
  const AppUsageTime({super.key});

  @override
  AppUsageState createState() => AppUsageState();
}

class AppUsageState extends State<AppUsageTime> {
  List<EventUsageInfo> events = [];
  Map<String?, NetworkInfo?> _netInfoMap = Map();
  Timer? _timer;
  String? _lastUpdated;
  int? _lastOpenTimeStamp; // 最新の eventType == 1 のタイムスタンプ
  final int _targetSeconds = 300; // 〇〇分経過したら遭遇の〇〇を設定するところ 秒数で設定

  @override
  void initState() {
    super.initState();
    initUsage();
    startTimer();
  }

  // タイマーの開始
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) async {
      await checkAppUsage();
      setState(() {
        _lastUpdated = DateTime.now().toIso8601String();
      });
    });
  }

  // アプリ使用時間のチェック
  Future<void> checkAppUsage() async {
    if (_lastOpenTimeStamp != null) {
      print("a");
      await initUsage();
      print("a");
      DateTime currentTime = DateTime.now();
      DateTime lastOpenTime =
          DateTime.fromMillisecondsSinceEpoch(_lastOpenTimeStamp!);

      // 経過時間を秒で計算
      int elapsedSeconds =
          (currentTime.difference(lastOpenTime).inSeconds / 60).toInt();

      String appName = events
              .firstWhere(
                  (event) => event.timeStamp == _lastOpenTimeStamp.toString())
              .packageName ??
          "不明なアプリ";

      DateTime now = DateTime.now(); // 現在の時間を取得
      String formattedTime = '${now.hour}:${now.minute}:${now.second}';

      if (elapsedSeconds >= _targetSeconds) {
        print("$appName:encountOK （時間: $formattedTime）"); // 300秒以上経過した場合に出力
      } else {
        print("$appName:$elapsedSeconds経過"); // _targetSeconds以下なら経過秒数を表示
      }
    }
  }

  // 初期データの読み込み
  Future<void> initUsage() async {
    try {
      UsageStats.grantUsagePermission();

      DateTime endDate = DateTime.now();
<<<<<<< HEAD:lib/app_usage_time.dart
      DateTime startDate = endDate.subtract(Duration(days: 1));

      List<EventUsageInfo> queryEvents =
          await UsageStats.queryEvents(startDate, endDate);

      // 最新の eventType == 1 イベントのタイムスタンプを取得
      for (var event in queryEvents.reversed) {
        if (event.eventType == '1') {
          _lastOpenTimeStamp = int.parse(event.timeStamp!);
          break; // 最新のイベントのみを使用するため、最初に見つかったらループを抜ける
=======
      DateTime startDate = endDate.subtract(const Duration(days: 1));

      List<EventUsageInfo> queryEvents = await UsageStats.queryEvents(startDate, endDate);
      List<NetworkInfo> networkInfos = await UsageStats.queryNetworkUsageStats(
        startDate,
        endDate,
        networkType: NetworkType.all,
      );

      Map<String?, NetworkInfo?> netInfoMap = {for (var v in networkInfos) v.packageName: v};

      List<UsageInfo> t = await UsageStats.queryUsageStats(startDate, endDate);

      for (var i in t) {
        if (double.parse(i.totalTimeInForeground!) > 0) {
          print(DateTime.fromMillisecondsSinceEpoch(int.parse(i.firstTimeStamp!)).toIso8601String());

          print(DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeStamp!)).toIso8601String());

          print(i.packageName);
          print(DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeUsed!)).toIso8601String());
          print(int.parse(i.totalTimeInForeground!) / 1000 / 60);

          print('-----\n');
>>>>>>> 16f720c23e04bbb490cbd035a868aa4d5cfe9fd0:lib/view/developer/app_usage_time.dart
        }
        print("_lastOpenTimeStamp: $_lastOpenTimeStamp");
      }

      setState(() {
        events = queryEvents.reversed.toList();
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // タイマーを解除
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD:lib/app_usage_time.dart
    List<EventUsageInfo> filteredEvents = events
        .where((event) => event.eventType == '1' || event.eventType == '2')
        .toList();

=======
    List<EventUsageInfo> filteredEvents = events.where((event) => event.eventType == '1' || event.eventType == '2').toList();
>>>>>>> 16f720c23e04bbb490cbd035a868aa4d5cfe9fd0:lib/view/developer/app_usage_time.dart
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Usage Stats"), actions: const [
          IconButton(
            onPressed: UsageStats.grantUsagePermission,
            icon: Icon(Icons.settings),
          ),
        ]),
        body: RefreshIndicator(
          onRefresh: initUsage,
<<<<<<< HEAD:lib/app_usage_time.dart
          child: Column(
            children: [
              if (_lastUpdated != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("最終更新: $_lastUpdated"),
                ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    var event = filteredEvents[index];
                    return ListTile(
                      title: Text(event.packageName!),
                      subtitle: Text(
                          "最終使用時刻: ${DateTime.fromMillisecondsSinceEpoch(int.parse(events[index].timeStamp!)).toIso8601String()}"),
                      trailing: Text(event.eventType!),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: filteredEvents.length,
                ),
              ),
            ],
=======
          child: ListView.separated(
            itemBuilder: (context, index) {
              var event = filteredEvents[index];
              var networkInfo = _netInfoMap[event.packageName];
              return ListTile(
                title: Text(event.packageName!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Last time used: ${DateTime.fromMillisecondsSinceEpoch(int.parse(events[index].timeStamp!)).toIso8601String()}"),
                    networkInfo == null
                        ? const Text("Unknown network usage")
                        : Text("Received bytes: ${networkInfo.rxTotalBytes}\n"
                            "Transfered bytes : ${networkInfo.txTotalBytes}"),
                  ],
                ),
                trailing: Text(event.eventType!),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: filteredEvents.length,
>>>>>>> 16f720c23e04bbb490cbd035a868aa4d5cfe9fd0:lib/view/developer/app_usage_time.dart
          ),
        ),
      ),
    );
  }
}
