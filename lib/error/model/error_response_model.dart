// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) => ErrorResponseModel.fromJson(json.decode(str));

String errorResponseModelToJson(ErrorResponseModel data) => json.encode(data.toJson());

class ErrorResponseModel {
  ErrorResponseModel({
    required this.statusCode,
    required this.error,
    required this.message,
  });

  int statusCode;
  String error;
  String message;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
    statusCode: json["status_code"],
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "error": error,
    "message": message,
  };
}