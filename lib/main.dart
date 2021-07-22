import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:tweety/utils/injection_container.dart' as di;
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Initiate dependency injection
  await di.init();
  ///Initiate firebase
  await Firebase.initializeApp();
  ///Enable crashlytics
  _enableCrashlytics();

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