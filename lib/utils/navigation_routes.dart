import 'package:flutter/material.dart';
import 'package:tweety/screens/user_interfaces/home/home_screen.dart';
import 'package:tweety/screens/user_interfaces/login_flow/login_screen.dart';

class NavigationRoutes {
  static const String LOGIN_PAGE = "login_view";
  static const String HOME_PAGE = "home_view";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRoutes.LOGIN_PAGE:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
          settings: RouteSettings(name: NavigationRoutes.LOGIN_PAGE),
        );
      case NavigationRoutes.HOME_PAGE:
        return MaterialPageRoute(
          builder: (_)=> HomeView(),
          settings: RouteSettings(name: NavigationRoutes.HOME_PAGE),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Invalid Route'),
                  ),
            ));
    }
  }
}
