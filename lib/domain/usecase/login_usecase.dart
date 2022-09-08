import 'package:datalines/data/network/failure.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/domain/model/models.dart';
import 'package:datalines/domain/repository/repository.dart';
import 'package:datalines/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final AuthenticationRepository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    return await _authenticationRepository
        .login(LoginRequest(input.username, input.password));
  }
}

class LoginUseCaseInput {
  String username;
  String password;

  LoginUseCaseInput(this.username, this.password);
}
