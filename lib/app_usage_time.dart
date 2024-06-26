import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppUsageTime extends StatelessWidget {
  const AppUsageTime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppUsageTime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const _AppUsageTime(title: 'App Usage Time'),
    );
  }
}

class _AppUsageTime extends StatefulWidget {
  const _AppUsageTime({super.key, required this.title});

  final String title;

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
      ),
    );
  }
}
