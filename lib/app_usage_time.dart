import 'package:flutter/material.dart';

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
  void CheckAppUsageTime() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'your App Usage Time is',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: CheckAppUsageTime,
        tooltip: 'Increment',
        child: const Icon(Icons.update),
      ),
    );
  }
}
