import 'package:battari/main.dart';
import 'package:battari/repository/user_repository.dart';
import 'package:battari/view/call.dart';
import 'package:battari/view/developer/developer_widgets.dart';
import 'package:battari/view/home.dart';
import 'package:battari/view/instruction/first_time_view.dart';
import 'package:battari/view/instruction/login_view.dart';
import 'package:battari/view/instruction/nickname_view.dart';
import 'package:battari/view/instruction/register_view.dart';
import 'package:battari/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const Splash();
      }),
  GoRoute(
    path: '/first_page',
    builder: (context, state) => FirstTimeView(),
  ),
  GoRoute(path: '/developer', builder: (context, state) => DeveloperWidgets()),
  GoRoute(path: '/register', builder: (context, state) => RegisterView()),
  GoRoute(path: '/nickname', builder: (context, state) => const NicknameView()),
  GoRoute(path: '/login', builder: (context, state) => LoginView()),
  GoRoute(path: '/home', builder: (context, state) => HomeView()),
  GoRoute(path: '/call', builder: (context, state) => Call()),
  GoRoute(
      path: '/foreground_init',
      builder: (context, state) {
        return const Splash();
      })
]);
