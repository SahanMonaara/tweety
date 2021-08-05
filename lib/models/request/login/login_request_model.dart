// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromJson(jsonString);
import 'dart:convert';

LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({
    required this.loginUserName,
    required this.loginPassword,
  });

  String loginUserName;
  String loginPassword;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        loginUserName: json["login_user_name"],
        loginPassword: json["login_password"],
      );

  Map<String, dynamic> toJson() => {
        "login_user_name": loginUserName,
        "login_password": loginPassword,
      };
}
