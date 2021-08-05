import 'package:flutter/material.dart';
import 'package:tweety/screens/user_interfaces/login_flow/login_screen.dart';


GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
class NavigationRoutes {

  static const String LOGIN_PAGE = "login_view";
  static const String TEST_PAGE = "logtest_view";
  static const String REGISTRATION_STEP_ONE_PAGE = "registration_step_one_view";
  static const String SELECT_USER_TYPE = "select_user_type";
  static const String EVENT_CATEGORY_PAGE = "event_category_view";
  static const String EVENT_TYPE_PAGE = "event_type_view";
  static const String EVENT_DETAILS_PAGE = "event_details_view";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRoutes.LOGIN_PAGE:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
          settings: RouteSettings(name: NavigationRoutes.LOGIN_PAGE),
        );

      // case NavigationRoutes.TEST_PAGE:
      //   final args =settings.arguments as LoginArgs;
      //   return MaterialPageRoute(
      //     builder: (_)=>TestNavi(args: args,),
      //     settings: RouteSettings(name: NavigationRoutes.TEST_PAGE,arguments: args),
      //   );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Invalid Route'),
                  ),
                ));
    }
  }
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
  return navigationKey.currentState!.pushNamed(routeName, arguments: arguments);
}
}
