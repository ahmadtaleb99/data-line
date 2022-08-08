import 'dart:async';
import 'dart:developer';

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
      : super(FormsState(submissionMap: {}, submissions: [])) {
    on<FieldValueChanged>(_onFieldValueChanged);
    on<NewFormRequested>(_onNewFormRequested);
    on<SubmitCanceled>(_onSubmitCanceled);
    on<SubmissionsRequested>(_onSubmissionsRequested);
    on<SubmissionUpdateRequested>(_onSubmissionUpdateRequested);
    on<FormSubmitted>(_onFormSubmitted);
    on<SubmissionDeleted>(_onSubmissionDeleted);
  }

  Future<void> _onFieldValueChanged(
      FieldValueChanged event, Emitter<FormsState> emit) async {
    var dropDown = state.formModel!.fields
        .firstWhere((element) => element.name == event.fieldName);
    Map<String, dynamic> map = Map.from(state.submissionMap);
    map[event.fieldName] = event.value;


    log(map.toString());
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

  Future<void> _onSubmissionUpdateRequested(
      SubmissionUpdateRequested event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = {};
    event.submission.fieldEntries.forEach((FieldEntry fieldEntry) {
      map[fieldEntry.name] = fieldEntry.value;
    });

    log(map.toString());
    emit(state.copyWith(submissionMap: map));
  }

  Future<void> _onSubmissionDeleted(
      SubmissionDeleted event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = {};
    await _assignedFormRepository.deleteSubmission(event.submission);
    List<Submission> submissions = List.from(state.submissions);
    submissions.remove(event.submission);
    emit(state.copyWith(submissions: submissions));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<FormsState> emit) async {
    Map map = state.submissionMap;

    List<FieldEntry> entries = map.entries
        .map((e) => FieldEntry(name: e.key, value: e.value))
        .toList();
    Submission submission =
        Submission(formName: state.formModel!.name, fieldEntries: entries);


    log(submission.fieldEntries[0].value.toString());
    log('form submitted');
    await _assignedFormRepository.addSubmission(submission);
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
      // if (submissions.isEmpty)
      //   stateBloc.add(StateRendererEvent(EmptyState('no data')));
      // else


      log(submissions.last.fieldEntries.first.value.toString());
        emit(state.copyWith(submissions: submissions));
    });
  }
}
