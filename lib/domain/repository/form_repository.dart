import 'package:dartz/dartz.dart';
import 'package:datalines/data/network/failure.dart';
import 'package:datalines/data/requests/forms/form_sync_request.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/data/responses/forms/forms_response.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/domain/model/models.dart';
import 'package:datalines/domain/model/node/node.dart';

abstract class AssignedFormRepository {
  Future<Either<Failure, List<FormModel>>> getAssignedForms(
      {bool? forceFromRemote});
  Either<Failure, List<Submission>> getFormSubmissions(String formId);
  Future<Either<Failure, SyncForm>> syncForm(FormSyncRequest formSyncRequest,
      {int chunkSize,
      void Function(int, int)? onChunkUploadProgress,
      void Function(int, int)? onChunksTotalProgress});
  bool formHasSubmissions(String formName);
  Future<void> addSubmission(Submission submission);
  Future<void> deleteSubmission(Submission submission);
  Future<void> updateSubmission(Submission submission);
  Future<Either<Failure, FormsHomeModel>> getFormsHomeModel(
      {bool? forceFromRemote});
  List<FormModel>? getInactiveForms();

  void cancelRequest(RequestType request);
  // int getLastSubmissionId();

}
