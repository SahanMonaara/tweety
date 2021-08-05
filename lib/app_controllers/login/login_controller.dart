import 'package:get/get.dart';
import 'package:tweety/API_repository/api_repository_for_handle_api_calls.dart';
import 'package:tweety/models/request/login/login_request_model.dart';
import 'package:tweety/network/network_config.dart';
import 'package:tweety/utils/injection_container.dart';

class LoginController extends GetxController {
  var loginSuccess = APIRequestStates.REQUEST_IDEAL;
  var loginDetails;
  final repositoryImpl = sl<APIRepositoryImpl>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<String> getLogin(LoginRequestModel request) async {
    try {
      loginSuccess = APIRequestStates.REQUEST_LOADING;
      update();
      loginDetails = await repositoryImpl.getLogin(request);
      if (loginDetails != null) {
        return APIRequestStates.REQUEST_SUCCESS;
      } else {
        return APIRequestStates.REQUEST_LOADING;
      }
    } catch (e) {
      loginSuccess = APIRequestStates.REQUEST_FAILED;
      update();
      return APIRequestStates.REQUEST_FAILED;
    } finally {}
  }
}
