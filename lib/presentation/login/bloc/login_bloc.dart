import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/app/form_validation.dart';
import 'package:form_builder_test/data/requests/requests.dart';
import 'package:form_builder_test/domain/repository/repository.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with FormValidation {


  bool _isPasswordValid(String password) => password.isNotEmpty;
  bool _isUsernameValid(String user) => user.isNotEmpty;
  final stateBloc = getIT<StateRendererBloc>();
  final _authentication = getIT<AuthenticationRepository>();
  String _username = '';
  String _password = '';


  LoginBloc() : super(LoginState(isPasswordValid: false,isUsernameValid: false,allValid: false,  hasLoggedIn: false)) {
    on<UserLoggedIn>(_onUserLoggedIn);
    on<UsernameChanged>(_onUserChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }




  Future<void> _onUserLoggedIn(
      UserLoggedIn event, Emitter<LoginState> emit) async {
    stateBloc.add(StateRendererEvent(LoadingState(stateRendererType:StateRendererType.POPUP_LOADING)));

    try{
      var either = await _authentication.login(LoginRequest(_username,_password));
      either.fold((failure) {
        stateBloc.add(StateRendererEvent(ErrorState(stateRendererType:StateRendererType.POPUP_ERROR, message: failure.message)));

      }

          , (login)  {
            stateBloc.add(StateRendererEvent(ContentState()));
            emit(state.copyWith(hasLoggedIn: true));
          });
    }
    catch (e) {
      stateBloc.add(StateRendererEvent(ErrorState(stateRendererType:StateRendererType.POPUP_ERROR, message: e.toString())));

    }


  }


  Future<void> _onUserChanged(
      UsernameChanged event, Emitter<LoginState> emit) async {
    _username = event.username;
    emit(state.copyWith(isUsernameValid: _isUsernameValid(event.username)));
    if(state.isPasswordValid && state.isUsernameValid)
      emit(state.copyWith(allValid: true));
    else
      emit(state.copyWith(allValid: false));


  }



  Future<void> _onPasswordChanged(
      PasswordChanged event, Emitter<LoginState> emit) async {

    _password = event.password;
    emit(state.copyWith(isPasswordValid: _isPasswordValid(event.password)));
    if(state.isPasswordValid && state.isUsernameValid)
      emit(state.copyWith(allValid: true));

    else
      emit(state.copyWith(allValid: false));


  }
}
