import 'package:datalines/data/network/failure.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/data/repository_impl/authentication_repository_impl.dart';
import 'package:datalines/domain/model/models.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository   {

  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
  Future<void> logout();
  Future<Either<Failure,ForgetPassword>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest);
  Future<Either<Failure,Authentication>> register(RegisterRequest registerRequest);
  Stream<AuthenticationStatus> get status ;
  void dispose();


}