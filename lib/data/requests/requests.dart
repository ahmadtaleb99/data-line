import 'package:dio/dio.dart';

  
  enum RequestType{
    Login,
    ForgetPassword,
    Register,
    GET_FORMS,
    GET_NODES,
    SYNC_FORM

  }
 class BaseRequest {
  late final   CancelToken _cancelToken;
  void setToken(CancelToken cancelToken)  {
    this._cancelToken = cancelToken;
  }




}

class LoginRequest extends BaseRequest {
  String username;
  String password;

  LoginRequest(this.username, this.password)
 ;
}

class ForgetPasswordRequest extends BaseRequest {
  String username;
  ForgetPasswordRequest(this.username);
}

class RegisterRequest extends BaseRequest {
  String username;
  String password;
  String phone;
  String countryCode;
  String profilePicture;

  RegisterRequest(this.username, this.password, this.phone, this.countryCode,
      this.profilePicture);
}
