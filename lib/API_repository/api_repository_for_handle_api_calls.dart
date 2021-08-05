import 'package:dartz/dartz.dart';
import 'package:tweety/data_sources/remote_data_source.dart';
import 'package:tweety/error/exceptions.dart';
import 'package:tweety/error/failures.dart';
import 'package:tweety/models/request/login/login_request_model.dart';
import 'package:tweety/models/response/login/login_response_model.dart';

abstract class APIRepository {
  Future<Either<Failures, LoginResponseModel>> getLogin(
      LoginRequestModel request);
}

class APIRepositoryImpl implements APIRepository {
  final RemoteDataSource remoteDataSource;

  APIRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, LoginResponseModel>> getLogin(
      LoginRequestModel request) async {
    try {
      final response = await remoteDataSource.getLogin(request);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorResponseModel));
    }
  }
}
