import 'package:datalines/data/network/failure.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/domain/model/models.dart';
import 'package:datalines/domain/repository/repository.dart';
import 'package:datalines/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final AuthenticationRepository _authenticationRepository;

  RegisterUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _authenticationRepository.register(RegisterRequest(
      input.username,
      input.password,
      input.phone,
      input.countryCode,
      input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  String username;
  String password;
  String phone;
  String countryCode;
  String profilePicture;

  RegisterUseCaseInput(this.username, this.password, this.phone,
      this.countryCode, this.profilePicture);
}
