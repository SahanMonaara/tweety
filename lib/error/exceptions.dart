

import 'model/error_response_model.dart';

class ServerException implements Exception {
  final ErrorResponseModel errorResponseModel;

  ServerException(this.errorResponseModel);
}

class CacheException implements Exception {}

class UnAuthorizedException implements Exception {}

class DioException implements Exception {
  final String message;

  DioException(this.message);
}
