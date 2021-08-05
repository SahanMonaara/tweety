import 'package:equatable/equatable.dart';

import 'model/error_response_model.dart';


abstract class Failures extends Equatable {
  Failures([List properties = const <dynamic>[]]);
  @override
  List<Object?> get props => props;
}

class ServerFailure extends Failures {
  final ErrorResponseModel errorResponse;

  ServerFailure(this.errorResponse);
}

class CacheFailure extends Failures {}

class ConnectionFailure extends Failures {}

class AuthorizedFailure extends Failures {}