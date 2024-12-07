import 'dart:convert';
import 'dart:io';

import 'package:battari/logger.dart';
import 'package:battari/model/battari_setting/battari_setting.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/service/souguu_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:battari/routes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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
  battariSetting = BattariSetting.fromJson(
      jsonDecode(await rootBundle.loadString('battari_setting.json')));
  var shared = await SharedPreferences.getInstance();
  await SentryFlutter.init((options) {
    options.dsn = battariSetting.sentry.dsn;
    options.tracesSampleRate = 1.0;
  },
      appRunner: () => runApp(ProviderScope(
            overrides: [
              sharedPreferencesProvider.overrideWithValue(shared),
            ],
            child: const Battari(),
          )));

  sentryInit();
}

void sentryInit() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    await Sentry.captureException(
      details.exception,
      stackTrace: details.stack,
    );
    FlutterError.presentError(details);
  };
}

class Battari extends ConsumerWidget with WidgetsBindingObserver {
  const Battari({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterForegroundTask.addTaskDataCallback((data) {
      logger.d("foreground task data: $data");
      logger.i("foreground task data: $data");
      if (context.mounted) {
        ref
            .read(souguuServiceProvider.notifier)
            .dealNotification(data.toString(), true);
      }
      // ref.read(souguuServiceProvider.notifier).disconnectWebsocket();
    });
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("stete = $state");
    switch (state) {
      case AppLifecycleState.inactive:
        print('非アクティブになったときの処理');
        break;
      case AppLifecycleState.paused:
        print('停止されたときの処理');
        break;
      case AppLifecycleState.resumed:
        print('再開されたときの処理');
        break;
      case AppLifecycleState.detached:
        print('破棄されたときの処理');
        break;
    }
  }
}
