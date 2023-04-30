
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../screen/login_page.dart';
import '../screen/home_main_page.dart';
import '../screen/splash_screen.dart';

class AppRoutes {
  static final homaPage =  GoRoute(
    path: '/home_page',
    builder: (BuildContext context, GoRouterState state) {
      return HomePageMain();
    },
  );

  static final loginPage =  GoRoute(
    path: '/login_page',
    builder: (BuildContext context, GoRouterState state) {
      return LoginPageW();
    },
  );

  static final GoRouter routerSettigs = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return  SplashScreen();
      },
      routes: <RouteBase>[
        homaPage,
        loginPage,
      ],
    ),
  ],
);


}


class AppRoutesConst {
  static const HOME = '/home_page';
  static const LOGIN  = '/login_page';
  static const SPLASH = '/splash';
}