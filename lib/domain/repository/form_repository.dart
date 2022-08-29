import 'package:form_builder_test/data/network/failure.dart';
import 'package:form_builder_test/data/requests/requests.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/domain/model/models.dart';
import 'package:dartz/dartz.dart';

abstract class AssignedFormRepository{

  Future<Either<Failure,AssignedForms>> getAssignedForms({bool? forceFromRemote});
  Either<Failure,List<Submission>> getFormSubmissions(String formName);
  Future<void> addSubmission(Submission submission);
  Future<void> deleteSubmission(Submission submission);
  Future<void> updateSubmission (Submission submission) ;
  // int getLastSubmissionId();

}