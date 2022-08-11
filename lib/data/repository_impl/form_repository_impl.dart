import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:form_builder_test/data/data_source/local_data_source.dart';
import 'package:form_builder_test/data/data_source/remote_data_source.dart';
import 'package:form_builder_test/data/database/hive_database.dart';
import 'package:form_builder_test/data/mapper/form_fields_mappers.dart';
import 'package:form_builder_test/data/network/error_handler.dart';
import 'package:form_builder_test/data/network/failure.dart';
import 'package:form_builder_test/data/network/network_info.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/domain/repository/form_repository.dart';

class AssignedFormRepositoryImpl implements AssignedFormRepository {

  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;


  AssignedFormRepositoryImpl(this._remoteDataSource, this._networkInfo, this._localDataSource);
  @override
  Future<Either<Failure, AssignedForms>> getAssignedForms(
      {bool? forceFromRemote}) async {


    //from database
    try{


      if(forceFromRemote != null && forceFromRemote) {
        return _getFromRemote();
      } else {
        final forms = _localDataSource.getAssignedForms();
        return Right(forms);
      }

    }

    // from api
     on DatabaseException {
      return _getFromRemote();

    }


    catch (error){
      print(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }




  }


  Future<Either<Failure, AssignedForms>> _getFromRemote  ()  async {

    try{
      if(!await _networkInfo.isConnected){
        return Left(ErrorTypeEnum.NO_INTERNET_CONNECTION.getFailure());
      }


      final response =  await _remoteDataSource.getAssignedForms();
      if (response.status == ApiInternal.FAILURE){
        return Left(Failure( ApiInternal.FAILURE, response.message ?? ResponseMessage.UNKNOWN));
      }

      //save to database
      _localDataSource.saveFormsToDataBase(response.toDomain());
      return Right(response.toDomain());
    }

    catch (error){
      print(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }

}

  @override
  Either<Failure, List<Submission>> getFormSubmissions(String formName) {

    try {
      return Right(_localDataSource.getSubmissions(formName)) ;
    }

    catch (error){

    return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<void> addSubmission(Submission submission) async {
    log('repo sub is about to be added : '+submission.toString());

    await _localDataSource.addSubmission(submission);
  }

  @override
  Future<void> deleteSubmission(Submission submission) async{
   await _localDataSource.deleteSubmission(submission);
  }

  @override
  Future<void> updateSubmission(Submission submission) async {
  await   _localDataSource.updateSubmission(submission);
  }



}