import 'dart:io';

import 'package:after_init/after_init.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tweety/utils/app_text_styles.dart';

import 'common_components/background/common_background_lower_component.dart';
import 'common_components/background/common_background_upper_component.dart';

abstract class BaseView extends StatefulWidget {
  BaseView({Key? key}) : super(key: key);
}

abstract class BaseViewState extends State<BaseView>
    with AfterInitMixin<BaseView> {
  ///common variables
  var pr;
  var adaptiveScreen;
  UpperComponent upperComponent = UpperComponent();
  AppTextStyles textStyles = AppTextStyles();
  LowerComponent lowerComponent = LowerComponent();

  ///init state
  @override
  void initState() {
    _fireBaseCloudMessagingListeners(context);
    _buildProgressDialog(context);
    super.initState();
  }

  ///after init state
  @override
  void didInitState() {
    ScreenUtil.init(
      BoxConstraints(
          minWidth: 0,
          maxWidth: MediaQuery.of(context).size.width,
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.height),
      designSize: Size(428, 926),
    );
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    adaptiveScreen = ScreenUtil();
  }

  @override
  Widget build(BuildContext context) {
    return build(context);
  }

  ///FCM
  void _fireBaseCloudMessagingListeners(BuildContext context) {
    if (Platform.isIOS) _iOSPermission();

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.body);
      print(message.notification!.title);
    });
  }

  ///get permissions for iOS in FCM
  void _iOSPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  _buildProgressDialog(BuildContext context) {}
}
