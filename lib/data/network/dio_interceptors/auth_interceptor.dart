import 'dart:developer';

import 'package:datalines/app/app_prefs.dart';
import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/data/network/error_handler.dart';
import 'package:datalines/domain/repository/repository.dart';
import 'package:dio/dio.dart';


class AuthInterceptor extends QueuedInterceptor {
  final _appPrefs = getIt<AppPreferences>();
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    log('on request ');
    // if (options.headers["requiresToken"] == false) {
    //   // if the request doesn't need token, then just continue to the next interceptor
    //   options.headers.remove("requiresToken"); //remove the auxiliary header
    //   return handler.next(options);
    // }

    final accessToken = _appPrefs.getAccessToken();
    //
    // if (accessToken == null ) {
    //
    //   // create custom dio error
    //   options.extra["tokenErrorType"] = TokenErrorType.tokenNotFound;
    //
    //   final error = DioError(requestOptions: options, type: DioErrorType.other);
    //   _logout();
    //   return handler.reject(error);
    // }


    // else  {
      // add access token to the request header
      options.headers["Authorization"] = "$accessToken";
      return handler.next(options);
    // }

  }



  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {

    log('interceptor onError');
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      // for some reasons the token can be invalidated before it is expired by the backend.
      // then we should navigate the user back to login page


      // create custom dio error
      err.type = DioErrorType.other;
      err.requestOptions.extra["tokenErrorType"] = TokenErrorType.failedToRegenerateAccessToken;
      handler.reject(err);
      _logout();

    }


    return handler.next(err);
  }

  Future<void> _logout() async {
   await getIt<AuthenticationRepository>().logout();
    // await Future.delayed(Duration.zero,() =>  );
  }

  /// return true if it is successfully regenerate the access token
  // Future<bool> _regenerateAccessToken() async {
  //   try {
  //     var dio = Dio(); // should create new dio instance because the request interceptor is being locked
  //
  //     // get refresh token from local storage
  //     final refreshToken = _localStorage.getRefreshToken();
  //
  //     // make request to server to get the new access token from server using refresh token
  //     final response = await dio.post(
  //       "https://yourDomain.com/api/refresh",
  //       options: Options(headers: {"Authorization": "Bearer $refreshToken"}),
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final newAccessToken = response.data["accessToken"]; // parse data based on your JSON structure
  //       _localStorage.saveAccessToken(newAccessToken); // save to local storage
  //       return true;
  //     } else if (response.statusCode == 401 || response.statusCode == 403) {
  //       // it means your refresh token no longer valid now, it may be revoked by the backend
  //       _logout(_dio);
  //       return false;
  //     } else {
  //       print(response.statusCode);
  //       return false;
  //     }
  //   } on DioError {
  //     return false;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}