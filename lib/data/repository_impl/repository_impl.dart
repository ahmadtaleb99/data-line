import 'dart:developer';


import 'package:dartz/dartz.dart';
import 'package:form_builder_test/data/data_source/local_data_source.dart';
import 'package:form_builder_test/data/mapper/mapper.dart';
import 'package:form_builder_test/data/network/error_handler.dart';
import 'package:form_builder_test/data/network/failure.dart';
import 'package:form_builder_test/data/network/network_info.dart';
import 'package:form_builder_test/data/requests/requests.dart';
import 'package:form_builder_test/data/responses/responses.dart';
import 'package:form_builder_test/domain/model/models.dart';
import 'package:form_builder_test/domain/repository/repository.dart';

import '../data_source/remote_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository{

  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;


  AuthenticationRepositoryImpl(this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
    if(!await _networkInfo.isConnected){
     return Left(ErrorTypeEnum.NO_INTERNET_CONNECTION.getFailure());
    }

    try {
      final AuthenticationResponse response =  await _remoteDataSource.login(loginRequest);
      if (response.status == ApiInternal.FAILURE){
        return Left(Failure( ApiInternal.FAILURE, response.message ?? ResponseMessage.UNKNOWN));
      }

      return Right(response.toDomain());
    }
    catch (error){
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ForgetPassword>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest) async {


   try {
     final response = await  _remoteDataSource.forgetPassword(forgetPasswordRequest);

     if (response.status == ApiInternal.FAILURE){
       return Left(Failure( ApiInternal.FAILURE, response.message ?? ResponseMessage.UNKNOWN));
     }


     return Right(response.toDomain());
   }
   catch (error){
     print('error catched');
     return Left(ErrorHandler.handle(error).failure);
   }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {
    if(!await _networkInfo.isConnected){
      return Left(ErrorTypeEnum.NO_INTERNET_CONNECTION.getFailure());
    }

    try {
      final AuthenticationResponse response =  await _remoteDataSource.register(registerRequest);
      if (response.status == ApiInternal.FAILURE){
        return Left(Failure( ApiInternal.FAILURE, response.message ?? ResponseMessage.UNKNOWN));
      }

      return Right(response.toDomain());
    }
    catch (error){
      return Left(ErrorHandler.handle(error).failure);
    }
  }




}