import 'package:battari/view/instruction/first_time_view.dart';
import 'package:battari/view/splash.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const Splash()),
  GoRoute(
    path: '/first_page',
    builder: (context, state) => FirstTimeView(),
  )
]);
