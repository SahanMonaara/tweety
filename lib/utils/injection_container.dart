import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweety/configurations/app_shared_data.dart';
import 'package:tweety/configurations/google_sign_in_provider.dart';
import 'package:tweety/screens/common_components/background/common_background_lower_component.dart';
import 'package:tweety/screens/common_components/background/common_background_upper_component.dart';

import 'app_constants.dart';
import 'app_text_styles.dart';
import 'navigation_routes.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppConstants());
  sl.registerLazySingleton(() => UpperComponent());
  sl.registerLazySingleton(() => LowerComponent());
  sl.registerLazySingleton(() => NavigationRoutes());
  sl.registerLazySingleton(() => AppTextStyles());
  sl.registerLazySingleton(() => AppSharedData(prefs: sl()));
  sl.registerLazySingleton(() => GoogleSignInProvider());
}
