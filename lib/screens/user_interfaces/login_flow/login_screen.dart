import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tweety/configurations/google_sign_in_provider.dart';
import 'package:tweety/screens/common_components/background/common_background_component.dart';
import 'package:tweety/screens/common_components/buttons/common_elevated_button.dart';
import 'package:tweety/screens/user_interfaces/home/home_screen.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/app_images.dart';
import 'package:tweety/utils/navigation_routes.dart';

import '../../base_view.dart';

class LoginView extends BaseView {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends BaseViewState {
  bool showPassword = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return HomeView();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something is Wrong!!'),
          );
        } else {
          return CommonBackgroundComponent(
            bottomSheetHeight: 780,
            children: [
              Positioned(
                top: adaptiveScreen.setHeight(270),
                left: adaptiveScreen.setWidth(20),
                child: Container(
                  width: adaptiveScreen.setWidth(400),
                  height: adaptiveScreen.setWidth(200),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.tweety),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Positioned(
                top: adaptiveScreen.setHeight(100),
                left: adaptiveScreen.setWidth(120),
                child: Container(
                  width: adaptiveScreen.setWidth(200),
                  height: adaptiveScreen.setWidth(200),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(AppImages.logo),
                    fit: BoxFit.fill,
                  )),
                ),
              ),

              Positioned(
                top: adaptiveScreen.setHeight(500),
                child: Container(
                  width: adaptiveScreen.setWidth(428),
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: adaptiveScreen.setSp(40),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                top: adaptiveScreen.setHeight(550),
                child: Container(
                  width: adaptiveScreen.setWidth(428),
                  child: Text(
                    "Sign into your account",
                    style: TextStyle(
                      fontSize: adaptiveScreen.setSp(20),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                top: adaptiveScreen.setHeight(600),
                child: Container(
                  width: adaptiveScreen.setWidth(428),
                  child: Text(
                    "This is a testing application for an assignment\nplease feel free to contact me on sahanmonaara2015@gmail.com",
                    style: TextStyle(
                      fontSize: adaptiveScreen.setSp(12),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                bottom: adaptiveScreen.setHeight(50),
                left: adaptiveScreen.setWidth(30),
                child: Column(
                  children: [
                    SizedBox(
                      height: adaptiveScreen.setHeight(10),
                    ),
                    Container(
                      child: CommonElevatedButton(
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          color: AppColors.primaryBackgroundColor,
                        ),
                        title: "Sign in with Google",
                        width: 370,
                        backgroundColor: AppColors.googleButtonBackgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    ));
  }
}
