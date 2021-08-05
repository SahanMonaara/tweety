import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
  ///Initiate dependency injection
  await di.init();
  ///Initiate firebase
  await Firebase.initializeApp();
  ///Enable crashlytics
  _enableCrashlytics();
  FlavorConfig(
      flavor: Flavor.DEV,
      name: "dev",
      color: AppColors.primaryBackgroundColor,
      values: FlavorValues(baseUrl: 'https://test_dev.com/'));
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  StringUtils.getApplicationVersion();
  runApp(
    GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: MyApp(),
    ),
  );
}
Future<void> _enableCrashlytics() async {
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  /// Pass all uncaught errors to Crashlytics.
  Function originalOnError = FlutterError.onError as Function;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    /// Forward to original handler.
    originalOnError(errorDetails);
  };
}