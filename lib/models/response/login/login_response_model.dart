// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);
import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    required this.token,
    required this.expiresIn,
    required this.login,
  });

  String token;
  String expiresIn;
  Login login;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json["token"],
        expiresIn: json["expiresIn"],
        login: Login.fromJson(json["login"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expiresIn": expiresIn,
        "login": login.toJson(),
      };
}

class Login {
  Login({
    required this.loginEmailVerification,
    required this.loginMobileVerification,
    required this.loginStatus,
    required this.loginStatusString,
    required this.loginCompanies,
    required this.isOauthSignup,
    required this.signupType,
    required this.id,
    required this.loginEmail,
    required this.loginMobile,
    required this.loginPassword,
    required this.loginType,
    required this.loginRole,
    required this.loginUid,
    required this.loginSalt,
    required this.userProfileId,
    required this.v,
  });

  bool loginEmailVerification;
  bool loginMobileVerification;
  bool loginStatus;
  String loginStatusString;
  List<String> loginCompanies;
  bool isOauthSignup;
  String signupType;
  String id;
  String loginEmail;
  String loginMobile;
  String loginPassword;
  String loginType;
  String loginRole;
  String loginUid;
  String loginSalt;
  String userProfileId;
  int v;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        loginEmailVerification: json["login_email_verification"],
        loginMobileVerification: json["login_mobile_verification"],
        loginStatus: json["login_status"],
        loginStatusString: json["login_status_string"],
        loginCompanies:
            List<String>.from(json["login_companies"].map((x) => x)),
        isOauthSignup: json["is_oauth_signup"],
        signupType: json["signup_type"],
        id: json["_id"],
        loginEmail: json["login_email"],
        loginMobile: json["login_mobile"],
        loginPassword: json["login_password"],
        loginType: json["login_type"],
        loginRole: json["login_role"],
        loginUid: json["login_uid"],
        loginSalt: json["login_salt"],
        userProfileId: json["user_profile_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "login_email_verification": loginEmailVerification,
        "login_mobile_verification": loginMobileVerification,
        "login_status": loginStatus,
        "login_status_string": loginStatusString,
        "login_companies": List<dynamic>.from(loginCompanies.map((x) => x)),
        "is_oauth_signup": isOauthSignup,
        "signup_type": signupType,
        "_id": id,
        "login_email": loginEmail,
        "login_mobile": loginMobile,
        "login_password": loginPassword,
        "login_type": loginType,
        "login_role": loginRole,
        "login_uid": loginUid,
        "login_salt": loginSalt,
        "user_profile_id": userProfileId,
        "__v": v,
      };
}
