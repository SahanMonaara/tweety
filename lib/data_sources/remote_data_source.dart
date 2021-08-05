

import 'package:tweety/models/request/login/login_request_model.dart';
import 'package:tweety/models/response/login/login_response_model.dart';
import 'package:tweety/network/api_helper.dart';

abstract class RemoteDataSource {
  Future<LoginResponseModel> getLogin(LoginRequestModel requestModel);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final ApiHelper apiHelper;

  RemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<LoginResponseModel> getLogin(LoginRequestModel requestModel) =>
      _getLogin(requestModel);

  ///-------------------------------Implementation-----------------------///
  Future<LoginResponseModel> _getLogin(LoginRequestModel requestModel) async {
    try {
      final response =
          await apiHelper.post('login/login', requestModel.toJson());
      return LoginResponseModel.fromJson(response);
    } on Exception catch (e) {
      throw e;
    }
  }
}
