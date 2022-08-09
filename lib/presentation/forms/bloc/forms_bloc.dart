import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/domain/repository/form_repository.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';

part 'forms_event.dart';
part 'forms_state.dart';

class FormsBloc extends Bloc<FormsEvent, FormsState>  {
  final stateBloc = getIT<StateRendererBloc>();

  final AssignedFormRepository _assignedFormRepository;
  FormsBloc(this._assignedFormRepository)
      : super(FormsState(valuesMap: {}, submissions: [],flowState: ContentState())) {
    on<FieldValueChanged>(_onFieldValueChanged);
    on<NewFormRequested>(_onNewFormRequested);
    on<SubmissionUpdateRequested>(_onSubmissionUpdateRequested);
    on<SubmitCanceled>(_onSubmitCanceled);
    on<SubmissionsRequested>(_onSubmissionsRequested);
    on<FormSubmitted>(_onFormSubmitted);
    on<SubmissionDeleted>(_onSubmissionDeleted);
    on<SubmissionUpdated>(_onSubmissionUpdated);
  }

  Future<void> _onFieldValueChanged(
      FieldValueChanged event, Emitter<FormsState> emit) async {
    var dropDown = state.formModel!.fields
        .firstWhere((element) => element.name == event.fieldName);
    Map<String, dynamic> map = Map.from(state.valuesMap);
    map[event.fieldName] = event.value;


    log(map.toString());
    emit(state.copyWith(valuesMap: map));
  }

  Future<void> _onNewFormRequested(
      NewFormRequested event, Emitter<FormsState> emit) async {
      log('_onNewFormRequested');
      log(state.valuesMap.toString());
    emit(state.copyWith(formModel: event.formModel,valuesMap: {}));
      log(state.valuesMap.toString());


  }
  Future<void> _onSubmissionUpdateRequested(
      SubmissionUpdateRequested event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = event.submission.toMap();
    log(map.toString()+'emititn from event bloc ');
    emit(state.copyWith(formModel: event.formModel,valuesMap: map));
  }

  Future<void> _onSubmitCanceled(
      SubmitCanceled event, Emitter<FormsState> emit) async {
    emit(state.copyWith(valuesMap: {}));
  }



  Future<void> _onSubmissionDeleted(
      SubmissionDeleted event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = {};
    await _assignedFormRepository.deleteSubmission(event.submission);
    List<Submission> submissions = List.from(state.submissions);
    submissions.remove(event.submission);
    if (submissions.isEmpty)
      emit(state.copyWith(flowState: EmptyState(AppStrings.emptySubs)));
    emit(state.copyWith(submissions: submissions));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<FormsState> emit) async {
    Map map = state.valuesMap;
    var newSub = Submission(formName: event.formModel.name, fieldEntries: _mapValuesToEntries(map) );

    await _assignedFormRepository.addSubmission(newSub);
  }


  Future<void> _onSubmissionUpdated(
      SubmissionUpdated event, Emitter<FormsState> emit) async {
    Map map = state.valuesMap;
    Submission submission = event.submission;
    int index = state.submissions.indexOf(event.submission);
    List<Submission> newSubmissions = List.from(state.submissions);


    Submission newSub = submission.copyWith(fieldEntries: _mapValuesToEntries(map));
    newSubmissions[index] = newSub;
    await _assignedFormRepository.updateSubmission(newSub);


    emit(state.copyWith(submissions: newSubmissions));

  }

  Future<void> _onSubmissionsRequested(
      SubmissionsRequested event, Emitter<FormsState> emit) async {
    final either =
        _assignedFormRepository.getFormSubmissions(event.formModel.name);
    either.fold((failure) {

    }, (submissions) {
      log(submissions.toString());
      if (submissions.isEmpty)
        emit(state.copyWith(flowState: EmptyState(AppStrings.emptySubs)));

      else    {
        emit(state.copyWith(submissions: List.from(submissions),flowState: ContentState()));
      }

    });
  }




  //private functions

  Submission _mapValuesToSubmission(Map submissionMap,Submission   submission){
    List<FieldEntry> entries = submissionMap.entries
        .map((e) => FieldEntry(name: e.key, value: e.value))
        .toList();
    submission = submission.copyWith(fieldEntries: entries);

    return submission;
  }



  List<FieldEntry> _mapValuesToEntries(Map submissionMap){
    List<FieldEntry> entries = submissionMap.entries
        .map((e) => FieldEntry(name: e.key, value: e.value))
        .toList();

    return entries;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
