part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class UserLoggedIn extends LoginEvent{
  final String username;
  final String password;

  UserLoggedIn(this.username,this.password);

  @override
  List<Object?> get props => [username,password];
}
