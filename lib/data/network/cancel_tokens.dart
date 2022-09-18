import 'package:dio/dio.dart';

class CancelTokenHandler {

  void refreshToken(){
    _syncFormCancelToken = CancelToken();
  }
  CancelToken _syncFormCancelToken = CancelToken();

   CancelToken get syncFormCancelToken => _syncFormCancelToken;
}