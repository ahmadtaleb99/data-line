import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/domain/repository/form_repository.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final stateBloc = getIT<StateRendererBloc>();
  final  AssignedFormRepository _assignedFormRepository;



  HomeBloc(this._assignedFormRepository) : super(HomeState(assignedForms: [])) {



    on<AssignedFormsRequested>(_onAssignedFormsRequested);


  }




  Future<void> _onAssignedFormsRequested(
      AssignedFormsRequested event, Emitter<HomeState> emit) async {
    stateBloc.add(StateRendererEvent(LoadingState(stateRendererType:StateRendererType.FULLSCREEN_LOADING)));

    try{
      var either = await _assignedFormRepository.getAssignedForms();
      either.fold((failure) {
        stateBloc.add(StateRendererEvent(ErrorState(stateRendererType:StateRendererType.FULLSCREEN_ERROR, message: failure.message)));

      }
          , (forms)  {
            stateBloc.add(StateRendererEvent(ContentState()));
            emit(state.copyWith(assignedForms: forms.data));
          });
    }
    catch (e) {
      log(e.toString());

      stateBloc.add(StateRendererEvent(ErrorState(stateRendererType:StateRendererType.FULLSCREEN_ERROR, message: e.toString())));

    }
  }
}
