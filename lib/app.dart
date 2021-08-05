import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweety/configurations/google_sign_in_provider.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/navigation_routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tweety',
        onGenerateRoute: NavigationRoutes.generateRoutes,
        initialRoute: NavigationRoutes.LOGIN_PAGE,
        theme: ThemeData(
          primaryColor: AppColors.primaryBackgroundColor,
          accentColor: AppColors.primaryBackgroundColor,
          highlightColor: AppColors.primaryButtonBackgroundColor,
          unselectedWidgetColor: AppColors.primaryTextColor,
        ),
      ));
}
