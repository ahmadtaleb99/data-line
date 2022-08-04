import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/data/requests/requests.dart';
import 'package:form_builder_test/domain/repository/repository.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>  {

  final stateBloc = getIT<StateRendererBloc>();
  final _authentication = getIT<AuthenticationRepository>();
  LoginBloc() : super(LoginInitial()) {
    on<UserLoggedIn>((event, emit) async {

      print('here!@!@');
      stateBloc.add(StateRendererEvent(LoadingState(stateRendererType:StateRendererType.FULLSCREEN_LOADING)));
      await _authentication.login(LoginRequest(event.username, event.password));

    });
  }
}
