
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../screen/login_page.dart';
import '../screen/home_main_page.dart';
import '../screen/registration_page.dart';
import '../screen/splash_screen.dart';

class AppRoutes {
  static final homaPage =  GoRoute(
    path: AppRoutesConst.HOME,
    builder: (BuildContext context, GoRouterState state) {
      return HomePageMain();
    },
  );

  static final loginPage =  GoRoute(
    path: AppRoutesConst.LOGIN,
    builder: (BuildContext context, GoRouterState state) {
      return LoginPageW();
    },
  );

  static final registrationPage =  GoRoute(
    path: AppRoutesConst.REGISTRATION,
    builder: (BuildContext context, GoRouterState state) {
      return RegistrationPageW();
    },
  );

  static final GoRouter routerSettigs = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutesConst.SPLASH,
      builder: (BuildContext context, GoRouterState state) {
        return  SplashScreen();
      },
      routes: <RouteBase>[
        homaPage,
        loginPage,
        registrationPage,
      ],
    ),
  ],
);


}


class AppRoutesConst {
  static const SPLASH = '/';
  static const HOME = 'home_page';
  static const LOGIN  = 'login_page';
  static const REGISTRATION  = 'registration_page';
}