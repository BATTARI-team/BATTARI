import 'package:battari/view/call.dart';
import 'package:battari/view/developer/developer_widgets.dart';
import 'package:battari/view/home.dart';
import 'package:battari/view/instruction/first_time_view.dart';
import 'package:battari/view/instruction/login_view.dart';
import 'package:battari/view/instruction/nickname_view.dart';
import 'package:battari/view/instruction/register_view.dart';
import 'package:battari/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(navigatorKey: navigatorKey, routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const Splash(isSouguu: false);
      }),
  GoRoute(
    path: '/first_page',
    builder: (context, state) => const FirstTimeView(),
  ),
  GoRoute(path: '/developer', builder: (context, state) => const DeveloperWidgets()),
  GoRoute(path: '/register', builder: (context, state) => const RegisterView()),
  GoRoute(path: '/nickname', builder: (context, state) => const NicknameView()),
  GoRoute(path: '/login', builder: (context, state) => const LoginView()),
  GoRoute(path: '/home', builder: (context, state) => const HomeView()),
  GoRoute(path: '/call', builder: (context, state) => Call()),
  GoRoute(
      path: '/foreground_init',
      builder: (context, state) {
        return const Splash(isSouguu: true);
      })
]);
