import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/enums.dart';
import 'package:tweety/utils/string_utils.dart';
import 'package:tweety/utils/injection_container.dart' as di;
import '../../app.dart';
import '../flavor_configurations.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  FlavorConfig(
      flavor: Flavor.DEV,
      name: "dev",
      color: AppColors.primaryBackgroundColor,
      values: FlavorValues(baseUrl: 'https://infact-moments-apis.uc.r.appspot.com/'));
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await di.init();
  await Firebase.initializeApp();
  StringUtils.getApplicationVersion();
  runApp(
    GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: MyApp(),
    ),
  );
}
