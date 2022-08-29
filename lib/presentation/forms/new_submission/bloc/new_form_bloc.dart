import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';

part 'new_form_event.dart';
part 'new_form_state.dart';

class NewFormBloc extends Bloc<NewFormEvent, NewFormState> {
  NewFormBloc() : super(NewFormState(flowState: ContentState() )) {

    on<StateChanged>(_onStateChanged);

  }



  Future<void> _onStateChanged(
      StateChanged event, Emitter<NewFormState> emit) async {

    emit(state.copyWith(
        flowState:  event.flowState));
  }
}
