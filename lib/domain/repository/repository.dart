import 'package:form_builder_test/data/network/failure.dart';
import 'package:form_builder_test/data/requests/requests.dart';
import 'package:form_builder_test/domain/model/models.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository{

  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure,ForgetPassword>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest);
  Future<Either<Failure,Authentication>> register(RegisterRequest registerRequest);

}