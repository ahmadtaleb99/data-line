part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {




  final AuthenticationStatus status;
  final User? user;

  @override
  List<Object?> get props => [status,user];

  const AuthenticationStatusChanged({
    required this.status,
    this.user,
  });
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}