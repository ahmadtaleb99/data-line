part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class UserLoggedIn extends LoginEvent{


  UserLoggedIn();

  @override
  List<Object?> get props => [];
}


class UsernameChanged extends LoginEvent{
  final String username;

  const UsernameChanged(this.username);

  @override
  List<Object?> get props => [username];
}

class PasswordChanged extends LoginEvent{
  final String password;

  PasswordChanged(this.password);

  List<Object?> get props => [password];

}