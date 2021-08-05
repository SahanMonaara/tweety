import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable{
  final String error;
  final String message;
  final int statusCode;

  ErrorResponse({required this.error, required this.message, required this.statusCode});
  @override
  List<Object?> get props => [error,message,statusCode];

}