import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/data/repository_impl/authentication_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/app/form_validation.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/domain/repository/repository.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer.dart';
import 'package:datalines/presentation/state_renderer_bloc/state_renderer_bloc.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer_impl.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with FormValidation {
  bool _isPasswordValid(String password) => password.isNotEmpty;
  bool _isUsernameValid(String user) => user.isNotEmpty;
  final _authbloc = getIt<AuthenticationBloc>();
  final _authentication = getIt<AuthenticationRepository>();
  String _username = 'test';
  String _password = 'test';

  LoginBloc()
      : super(LoginState(
            flowState: ContentState(),
            isPasswordValid: false,
            isUsernameValid: false,
            allValid: true,
            hasLoggedIn: false)) {
    on<UserLoggedIn>(_onUserLoggedIn);
    on<UsernameChanged>(_onUserChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  Future<void> _onUserLoggedIn(
      UserLoggedIn event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
        flowState:
            LoadingState(stateRendererType: StateRendererType.POPUP_LOADING)));
    try {
      var either =
          await _authentication.login(LoginRequest(_username, _password));
      either.fold((failure) {
        emit(state.copyWith(
            flowState: ErrorState(
                stateRendererType: StateRendererType.POPUP_ERROR,
                message: failure.message)));
      }, (login) {
        emit(state.copyWith(
          hasLoggedIn: true,
        ));
      });
    } catch (e) {
      emit(state.copyWith(
          flowState: ErrorState(
              stateRendererType: StateRendererType.POPUP_ERROR,
              message: e.toString())));
    }
  }

  Future<void> _onUserChanged(
      UsernameChanged event, Emitter<LoginState> emit) async {
    _username = event.username;
    emit(state.copyWith(isUsernameValid: _isUsernameValid(event.username)));
    if (state.isPasswordValid && state.isUsernameValid)
      emit(state.copyWith(allValid: true));
    else
      emit(state.copyWith(allValid: false));
  }

  Future<void> _onPasswordChanged(
      PasswordChanged event, Emitter<LoginState> emit) async {
    _password = event.password;
    emit(state.copyWith(isPasswordValid: _isPasswordValid(event.password)));
    if (state.isPasswordValid && state.isUsernameValid)
      emit(state.copyWith(allValid: true));
    else
      emit(state.copyWith(allValid: false));
  }

  @override
  Future<void> close() {
    log('login bloc closed');
    return super.close();
  }
}
