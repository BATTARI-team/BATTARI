import 'dart:convert';
import 'dart:io';

import 'package:battari/model/battari_setting.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:battari/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}

late BattariSetting battariSetting;

// ignore: non_constant_identifier_names
String Token = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.initCommunicationPort();
  battariSetting = BattariSetting.fromJson(jsonDecode(await rootBundle.loadString('battari_setting.json')));
  var shared = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(shared),
    ],
    child: const Battari(),
  ));
}

class Battari extends StatelessWidget {
  const Battari({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint("Battari build");
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        dividerColor: Colors.transparent,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
