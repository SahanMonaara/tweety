
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tweety/app.dart';
import 'package:tweety/configurations/flavor_configurations.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/enums.dart';
import 'package:tweety/utils/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:tweety/utils/string_utils.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  FlavorConfig(
      flavor: Flavor.QA,
      name: "qa",
      color: AppColors.primaryBackgroundColor,
      values: FlavorValues(baseUrl: ''));
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await di.init();
  await Firebase.initializeApp();
  _enableCrashlytics();
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
