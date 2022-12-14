import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:datalines/app/extenstions.dart';
import 'package:datalines/data/data_source/local_data_source.dart';
import 'package:datalines/data/data_source/remote_data_source.dart';
import 'package:datalines/data/database/hive_database.dart';
import 'package:datalines/data/mapper/form_fields_mappers.dart';
import 'package:datalines/data/mapper/mapper.dart';
import 'package:datalines/data/network/error_handler.dart';
import 'package:datalines/data/network/failure.dart';
import 'package:datalines/data/network/network_info.dart';
import 'package:datalines/data/requests/forms/form_sync_request.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/data/responses/forms/forms_response.dart';
import 'package:datalines/data/responses/forms/node_response/node_response.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/domain/model/node/node.dart';
import 'package:datalines/domain/repository/form_repository.dart';

class AssignedFormRepositoryImpl implements AssignedFormRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  AssignedFormRepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);
  @override
  Future<Either<Failure, List<FormModel>>> getAssignedForms(
      {bool? forceFromRemote}) async {
    // from database
    try {
      if (forceFromRemote != null && forceFromRemote) {
        return _getFormsFromRemote();
      } else {
        final forms = _localDataSource.getAssignedForms();
        if (forms != null)
          return Right(forms);
        else
          return _getFormsFromRemote();
      }
    } catch (error) {
      print(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, List<FormModel>>> _getFormsFromRemote() async {
    try {
      if (!await _networkInfo.isConnected) {
        return Left(ErrorTypeEnum.NO_INTERNET_CONNECTION.getFailure());
      }

      final response = await _remoteDataSource.getAssignedForms();
      if (response.status == ApiInternal.FAILURE) {
        return Left(Failure(1, response.message ?? ResponseMessage.UNKNOWN));
      }

      //save to database
      await _localDataSource.saveFormsToDataBase(response.toDomain());
      log('saved');
      return Right(response.toDomain());
    } catch (error) {
      log(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Either<Failure, List<Submission>> getFormSubmissions(String formName) {
    try {
      return Right(_localDataSource.getSubmissions(formName));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<void> addSubmission(Submission submission) async {
    await _localDataSource.addSubmission(submission);
  }

  @override
  Future<void> deleteSubmission(Submission submission) async {
    await _localDataSource.deleteSubmission(submission);
  }

  @override
  Future<void> updateSubmission(Submission submission) async {
    await _localDataSource.updateSubmission(submission);
  }

  Future<Either<Failure, FormsHomeModel>> getFormsHomeModel(
      {bool? forceFromRemote}) async {
    // from database
    try {
      if (forceFromRemote != null && forceFromRemote) {
        return _getFormsHomeModelFromRemote();
      } else {
        final forms = _localDataSource.getAssignedForms();
        final nodes = _localDataSource.getNodes();

        if (forms == null && nodes == null) {
          return _getFormsHomeModelFromRemote();
        }
        return Right(FormsHomeModel(forms: forms ?? [], nodes: nodes!));
      }
    } catch (error) {
      print(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, FormsHomeModel>> _getFormsHomeModelFromRemote() async {
    try {
      if (!await _networkInfo.isConnected) {
        return Left(ErrorTypeEnum.NO_INTERNET_CONNECTION.getFailure());
      }

      final request1 = _remoteDataSource.getAssignedForms();
      final request2 = _remoteDataSource.getNodes();

      final responses = await Future.wait([request1, request2]);

      if (responses.any((response) => response.status == ApiInternal.FAILURE)) {
        final falseResponse = responses
            .firstWhere((element) => element.status == ApiInternal.FAILURE);
        return Left(
            Failure(1, falseResponse.message ?? ResponseMessage.UNKNOWN));
      }

      ////// success
      final forms = responses[0] as AssignedFormsResponse;
      final nodes = responses[1] as NodeBaseResponse;
      //save to database
      final formsModel = forms.toDomain();
      final nodesModel = nodes.toDomain();

      List<FormModel>? oldForms = _localDataSource.getAssignedForms();
      if (oldForms != null) {

        //if the old form does not exist in any of the new forms
        // and has no submissions, then its considered inactive.
        List<FormModel> inactiveForms = oldForms
            .where((oldForm) =>
                !formsModel.any((newForm) => newForm.name == oldForm.name) &&
                _localDataSource.formHasSubmissions(oldForm.name))
            .toList();
        if (inactiveForms.isNotEmpty)
          await _localDataSource.saveInactiveForms(inactiveForms);
      }

      await _localDataSource.saveFormsToDataBase(formsModel);
      await _localDataSource.saveNodes(nodesModel);

      log(nodesModel.toString());
      log('saved');
      return Right(FormsHomeModel(forms: formsModel, nodes: nodesModel));
    } catch (error) {
      log(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  List<FormModel>? getInactiveForms() {
    return _localDataSource.getInactiveForms();
  }

  @override
  Future<Either<Failure, SyncForm>> syncForm(FormSyncRequest formSyncRequest,
      {int chunkSize = 5,
      void Function(int send, int total)? onChunkUploadProgress,
      void Function(int send, int total)? onChunksTotalProgress}) async {
    if (!await _networkInfo.isConnected) {
      return Left(ErrorTypeEnum.NO_INTERNET_CONNECTION.getFailure());
    }
    try {
      final submissions = formSyncRequest.submissions;

      List<List<Submission>> submissionsChunks =
          submissions.asChunks(chunkSize);
      SyncForm? syncForm;
       int hasBeenSyncedNumber = 0 ;

      for (int submissionChunkIndex = 0;
          submissionChunkIndex < submissionsChunks.length;
          submissionChunkIndex++) {
         int currentChunkSize = submissionsChunks[submissionChunkIndex].length;
         hasBeenSyncedNumber += currentChunkSize;

        final request = formSyncRequest.copyWith(
            submissions: List.from(submissionsChunks[submissionChunkIndex]));

        final response = await _remoteDataSource.syncForm(request,
            onSyncProgress: onChunkUploadProgress);

        //status false
        if (response.status == ApiInternal.FAILURE) {
          return Left(Failure(1, response.message ?? ResponseMessage.UNKNOWN));
        }

        //status true
        syncForm = response.toDomain();

        if(!syncForm.hasSubmitPermission) {
          final form = _localDataSource.getForm(request.formId);
          if(form != null ){
            await _localDataSource.saveInactiveForm(form);
            await _localDataSource.deleteForm(form);
          }

        }
        onChunksTotalProgress?.call(hasBeenSyncedNumber,submissions.length);

        _localDataSource.deleteSubmissionsRange(formSyncRequest.formId, 0, currentChunkSize);

      }

      log('all forms synced');
    if(!syncForm!.hasSubmitPermission) {
      await _localDataSource.deleteInactiveForm(formSyncRequest.formId);
    }
      return Right(syncForm!);
    } catch (error) {

      log('repo catched error' + error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  bool formHasSubmissions(String formId) {
    return _localDataSource.formHasSubmissions(formId);
  }

  @override
  void cancelRequest(RequestType request) {
    _remoteDataSource.cancelRequest(request);
  }
}
