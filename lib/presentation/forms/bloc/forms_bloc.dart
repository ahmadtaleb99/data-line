import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/domain/repository/form_repository.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';

part 'forms_event.dart';
part 'forms_state.dart';

class FormsBloc extends Bloc<FormsEvent, FormsState> {
  final stateBloc = getIT<StateRendererBloc>();

  final AssignedFormRepository _assignedFormRepository;
  FormsBloc(this._assignedFormRepository)
      : super(FormsState(submissionMap: {},submissions: [])) {
    on<FieldValueChanged>(_onDropDownValueChanged);
    on<NewFormRequested>(_onNewFormRequested);
    on<SubmitCanceled>(_onSubmitCanceled);
    on<SubmissionsRequested>(_onSubmissionsRequested);
  }

  Future<void> _onDropDownValueChanged(
      FieldValueChanged event, Emitter<FormsState> emit) async {
    var dropDown = state.formModel!.fields
        .firstWhere((element) => element.name == event.fieldName);
    Map<String, dynamic> map = Map.from(state.submissionMap);
    map[event.fieldName] = event.value;

    emit(state.copyWith(submissionMap: map));
  }

  Future<void> _onNewFormRequested(
      NewFormRequested event, Emitter<FormsState> emit) async {
    emit(state.copyWith(formModel: event.formModel));
  }

  Future<void> _onSubmitCanceled(
      SubmitCanceled event, Emitter<FormsState> emit) async {
    emit(state.copyWith(submissionMap: {}));
  }

  Future<void> _onSubmissionsRequested(
      SubmissionsRequested event, Emitter<FormsState> emit) async {
    final either =
        _assignedFormRepository.getFormSubmissions(event.formModel.name);
    either.fold((failure) {
      stateBloc.add(StateRendererEvent(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR,
          message: failure.message)));
    }, (submissions) {
      if (submissions.isEmpty)
        stateBloc.add(StateRendererEvent(EmptyState( 'no data')));

      else emit(state.copyWith(submissions: submissions));
    });


  }
}
