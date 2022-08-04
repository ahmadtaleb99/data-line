import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:meta/meta.dart';

part 'state_renderer_event.dart';
part 'state_renderer_state.dart';

class StateRendererBloc extends Bloc<StateRendererEvent, StateRendererState> {
  StateRendererBloc() : super(StateRendererState(ContentState())) {
    on<StateRendererEvent>((event, emit) {
      emit(StateRendererState(event.flowState));
    });
  }
}
