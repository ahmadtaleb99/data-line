import 'package:form_builder_test/data/network/failure.dart';
import 'package:form_builder_test/data/requests/requests.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/domain/model/models.dart';
import 'package:dartz/dartz.dart';

abstract class AssignedFormRepository{

  Future<Either<Failure,AssignedForms>> getAssignedForms();

}