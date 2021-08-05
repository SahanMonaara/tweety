import 'package:get/get.dart';
import 'package:tweety/API_repository/api_repository_for_handle_api_calls.dart';
import 'package:tweety/data_sources/remote_data_source.dart';
import 'package:tweety/network/api_helper.dart';

import 'login/login_controller.dart';


class AllControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut(() => APIRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(apiHelper: ApiHelper())));
  }
}
