import 'package:datalines/data/network/failure.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/domain/model/models.dart';
import 'package:datalines/domain/repository/repository.dart';
import 'package:datalines/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUsecase extends BaseUseCase<ForgetPasswordUsecaseInput, ForgetPassword> {
  final AuthenticationRepository _authenticationRepository;


  ForgetPasswordUsecase(this._authenticationRepository);

  @override
  Future<Either<Failure, ForgetPassword>> execute(ForgetPasswordUsecaseInput input) async {
    return await _authenticationRepository.forgetPassword(ForgetPasswordRequest(input.username));
  }


}


class ForgetPasswordUsecaseInput {
  String username;

  ForgetPasswordUsecaseInput(this.username);
}