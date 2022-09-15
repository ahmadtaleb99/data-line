
import 'package:datalines/app/app_prefs.dart';
import 'package:datalines/data/network/api_constants.dart';
import 'package:datalines/data/network/dio_interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:datalines/presentation/resources/constants_manager.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';



const String APPLICATION_JSON = "application/json";
const String MULTIPART_FORMDATA = "multipart/form-data";
// ignore: constant_identifier_names
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "langauge";


class DioFactory {

static   Map<String, String> _headers = {};
  final AppPreferences _appPrefs ;




  static Map<String, String>  get  getDefaultHeaders  => _headers;




  Future<Dio> getDio () async {
    final  dio= Dio();
    final appLanguage = _appPrefs.getAppLanguage();
    _headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: "SEND TOKEN HERE",
      DEFAULT_LANGUAGE: appLanguage
    };






    dio.options = BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: _headers,
        receiveTimeout: ApiConstants.apiTimeOut,
        sendTimeout: ApiConstants.apiTimeOut);


    //loggging in debug mode
    if(!kReleaseMode){
      dio.interceptors.addAll([AuthInterceptor(),PrettyDioLogger(
        request : true,
         requestHeader : true,
         requestBody : true,
         // responseHeader : true,
         // responseBody : true,
      )]);
    }



    return dio;
  }

  DioFactory(this._appPrefs);
}