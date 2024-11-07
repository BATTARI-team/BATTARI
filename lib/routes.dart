import 'package:battari/view/developer/developer_widgets.dart';
import 'package:battari/view/home.dart';
import 'package:battari/view/instruction/first_time_view.dart';
import 'package:battari/view/instruction/login_view.dart';
import 'package:battari/view/instruction/nickname_view.dart';
import 'package:battari/view/instruction/register_view.dart';
import 'package:battari/view/splash.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => Splash()),
  GoRoute(
    path: '/first_page',
    builder: (context, state) => FirstTimeView(),
  ),
  GoRoute(path: '/developer', builder: (context, state) => DeveloperWidgets()),
  GoRoute(path: '/register', builder: (context, state) => RegisterView()),
  GoRoute(path: '/nickname', builder: (context, state) => const NicknameView()),
  GoRoute(path: '/login', builder: (context, state) => LoginView()),
  GoRoute(path: '/home', builder: (context, state) => HomeView())
]);
