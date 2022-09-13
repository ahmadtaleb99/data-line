import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:datalines/data/repository_impl/authentication_repository_impl.dart';
import 'package:datalines/domain/model/models.dart';
import 'package:datalines/domain/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus> _subscription;
AuthenticationBloc(this._authenticationRepository) : super(const AuthenticationState.unknown()) {


  on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
  on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
      _subscription = _authenticationRepository.status.listen((AuthenticationStatus status) {
        log('first LISTEN');
        add(AuthenticationStatusChanged(status: status));
      });

  }


  Future<void> _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit,
      ) async {
    switch (event.status) {


      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        log('asdasdoas-kds--kads');
        return emit(
             AuthenticationState.authenticated(event.user ?? User.empty)
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event,
      Emitter<AuthenticationState> emit,
      ) async {

    await _authenticationRepository.logout();
  }


  @override
  Future<void> close() {
    _subscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }


}
