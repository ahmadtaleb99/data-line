import 'package:dartz/dartz.dart';
import 'package:datalines/data/network/failure.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/domain/model/models.dart';
import 'package:datalines/domain/model/node/node.dart';

abstract class AssignedFormRepository{

  Future<Either<Failure,AssignedForms>> getAssignedForms({bool? forceFromRemote});
  Either<Failure,List<Submission>> getFormSubmissions(String formName);
  Future<void> addSubmission(Submission submission);
  Future<void> deleteSubmission(Submission submission);
  Future<void> updateSubmission (Submission submission) ;
  Future<Either<Failure,List<Node>>> getNodes();
  Future<Either<Failure,FormsHomeModel>> getFormsHomeModel({bool? forceFromRemote});
  // int getLastSubmissionId();

}