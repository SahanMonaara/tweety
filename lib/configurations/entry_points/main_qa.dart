
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tweety/app.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:tweety/utils/enums.dart';
import 'package:tweety/utils/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:tweety/utils/string_utils.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  Flavor flavor = FlavorConfig.instance.variables['flavor'];
  flavor = Flavor.QA;
  FlavorConfig(
      name: 'qa',
      color: Colors.red,
      location: BannerLocation.topStart,
      variables: {
        'baseUrl': 'https://test_qa.com/',
        'flavor': flavor,
      });
  WidgetsFlutterBinding.ensureInitialized();

  ///Initiate dependency injection
  await di.init();
  ///Initiate firebase
  await Firebase.initializeApp();
  ///Enable crashlytics
  _enableCrashlytics();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  StringUtils.getApplicationVersion();
  runApp(
    GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: FlavorBanner(child: MyApp()),
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
