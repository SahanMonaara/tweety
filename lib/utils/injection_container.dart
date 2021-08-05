import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweety/API_repository/api_repository_for_handle_api_calls.dart';
import 'package:tweety/configurations/app_shared_data.dart';
import 'package:tweety/configurations/push_notification_manager.dart';
import 'package:tweety/data_sources/remote_data_source.dart';
import 'package:tweety/network/api_helper.dart';
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
  sl.registerLazySingleton(() => PushNotificationsManager());
  sl.registerLazySingleton(() => ApiHelper());
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(apiHelper: sl()));
  sl.registerFactory<APIRepositoryImpl>(() => APIRepositoryImpl(remoteDataSource: sl()));
}
