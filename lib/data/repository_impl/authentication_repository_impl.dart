import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:datalines/app/app_prefs.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/data/data_source/local_data_source.dart';
import 'package:datalines/data/mapper/mapper.dart';
import 'package:datalines/data/network/error_handler.dart';
import 'package:datalines/data/network/failure.dart';
import 'package:datalines/data/network/network_info.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/data/responses/responses.dart';
import 'package:datalines/domain/model/models.dart';
import 'package:datalines/domain/repository/repository.dart';

import '../data_source/remote_data_source.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final _appPrefs = getIt<AppPreferences>();
  final _controller = StreamController<AuthenticationStatus>();



  AuthenticationRepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (!await _networkInfo.isConnected) {
      return Left(ErrorTypeEnum.NO_INTERNET_CONNECTION.getFailure());
    }

    try {
      final AuthenticationResponse response =
          await _remoteDataSource.login(loginRequest);
      if (response.status == ApiInternal.FAILURE) {
        return Left(Failure(1, response.message ?? ResponseMessage.UNKNOWN));
      }

      if(response.accessToken != null){
        await _appPrefs.saveAccessToken(response.accessToken!);
      }

      return Right(response.toDomain());
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ForgetPassword>> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest) async {
    try {
      final response =
          await _remoteDataSource.forgetPassword(forgetPasswordRequest);

      if (response.status == ApiInternal.FAILURE) {
        return Left(Failure(1, response.message ?? ResponseMessage.UNKNOWN));
      }

      return Right(response.toDomain());
    } catch (error) {
      print('error catched');
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (!await _networkInfo.isConnected) {
      return Left(ErrorTypeEnum.NO_INTERNET_CONNECTION.getFailure());
    }

    try {
      final AuthenticationResponse response =
          await _remoteDataSource.register(registerRequest);
      if (response.status == ApiInternal.FAILURE) {
        return Left(Failure(1, response.message ?? ResponseMessage.UNKNOWN));
      }

      return Right(response.toDomain());
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }


  //initial auth status
  @override
  Stream<AuthenticationStatus> get status async* {

        log('first sream');
    yield _appPrefs.getAccessToken() == null
        ? AuthenticationStatus.unauthenticated
        : AuthenticationStatus.authenticated;
      yield* _controller.stream;
  }



  @override
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }


  @override
  Future<void> logout() async {
   await  _appPrefs.logout();
    _controller.add(AuthenticationStatus.unauthenticated);

  }

  void dispose() => _controller.close();

}
