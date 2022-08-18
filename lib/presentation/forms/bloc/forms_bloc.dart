import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/model/dropdown_item_model/dropdown_item_model.dart';
import 'package:form_builder_test/domain/model/dropdown_model/dropdown_model.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/domain/repository/form_repository.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';

part 'forms_event.dart';
part 'forms_state.dart';

class FormsBloc extends Bloc<FormsEvent, FormsState> {
  final stateBloc = getIT<StateRendererBloc>();

  final AssignedFormRepository _assignedFormRepository;
  FormsBloc(this._assignedFormRepository)
      : super(FormsState(
    assignedForms: [],
            valuesMap: {}, submissions: [], flowState: ContentState())) {
    on<AssignedFormsRequested>(_onAssignedFormsRequested);
    on<AssignedFormsRefreshRequested>(_onAssignedFormsRefreshRequested);
    on<FieldValueChanged>(_onFieldValueChanged);
    on<DropDownValueChanged>(_onDropDownValueChanged);
    on<NewFormRequested>(_onNewFormRequested);
    on<SubmissionUpdateRequested>(_onSubmissionUpdateRequested);
    on<SubmitCanceled>(_onSubmitCanceled);
    // on<SubmissionsRequested>(_onSubmissionsRequested);
    on<FormSubmitted>(_onFormSubmitted);
    // on<SubmissionDeleted>(_onSubmissionDeleted);
    on<SubmissionUpdated>(_onSubmissionUpdated);
  }


  Future<void> _onAssignedFormsRequested(
      AssignedFormsRequested event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        flowState: LoadingState(
            stateRendererType: StateRendererType.FULLSCREEN_LOADING)));

    try {
      var either = await _assignedFormRepository.getAssignedForms();
      either.fold((failure) {
        emit(state.copyWith(
            flowState: ErrorState(
                stateRendererType: StateRendererType.FULLSCREEN_ERROR,
                message: failure.message)));
      }, (forms) {
        emit(state.copyWith(
            assignedForms: forms.data, flowState: ContentState()));
      });
    } catch (e) {
      emit(state.copyWith(
          flowState: ErrorState(
              stateRendererType: StateRendererType.FULLSCREEN_ERROR,
              message: e.toString())));
    }
  }

  Future<void> _onAssignedFormsRefreshRequested(
      AssignedFormsRefreshRequested event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        flowState: LoadingState(
            stateRendererType: StateRendererType.POPUP_LOADING)));

    try {
      var either = await _assignedFormRepository.getAssignedForms(forceFromRemote: true);
      either.fold((failure) {
        emit(state.copyWith(
            flowState: ErrorState(
                stateRendererType: StateRendererType.POPUP_ERROR,
                message: failure.message)));
      }, (forms) {
        emit(state.copyWith(
            assignedForms: forms.data, flowState: ContentState()));
      });
    } catch (e) {
      emit(state.copyWith(
          flowState: ErrorState(
              stateRendererType: StateRendererType.POPUP_ERROR,
              message: e.toString())));
    }
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

  Future<void> _onDropDownValueChanged(
      DropDownValueChanged event, Emitter<FormsState> emit) async {
    var formModel = state.formModel!.copyWith();

    Map<String, dynamic> map = Map.from(state.valuesMap);
    map[event.fieldName] = event.value;

   //  DropDownModel dropDown = formModel.getField(event.fieldName) as DropDownModel;
   //
   //  List<DropDownModel> children = formModel.getRelatedDropDowns(dropDown.name);
   // children.map((childDropDown) {
   //   log(state.assignedForms.toString()+'my log ');
   //      childDropDown = childDropDown.copyWith(
   //        values: (state.assignedForms.firstWhere((element) => formModel.name == element.name).getField(childDropDown.name) as DropDownModel).values
   //
   //            .where((item) => item.parent == event.value)
   //            .toList());
   //
   //    formModel.fields[formModel.fields.indexWhere((element) => element.name == childDropDown.name)] = childDropDown;
   //      map[childDropDown.name] = null;
   //  }).toList();

    emit(state.copyWith(formModel: formModel, valuesMap: map));
  }

  Future<void> _onNewFormRequested(
      NewFormRequested event, Emitter<FormsState> emit) async {
    log('_onNewFormRequested');
    log(state.valuesMap.toString());
    emit(state.copyWith(formModel: event.formModel, valuesMap: {}));
    log(state.valuesMap.toString());
  }

  Future<void> _onSubmissionUpdateRequested(
      SubmissionUpdateRequested event, Emitter<FormsState> emit) async {
    Map<String, dynamic> map = event.submission.toMap();
    log(map.toString() + 'emititn from event bloc ');
    emit(state.copyWith(formModel: event.formModel, valuesMap: map));
  }

  Future<void> _onSubmitCanceled(
      SubmitCanceled event, Emitter<FormsState> emit) async {
    emit(state.copyWith(valuesMap: {}));
  }

  // Future<void> _onSubmissionDeleted(
  //     SubmissionDeleted event, Emitter<FormsState> emit) async {
  //   Map<String, dynamic> map = {};
  //   await _assignedFormRepository.deleteSubmission(event.submission);
  //   List<Submission> submissions = List.from(state.submissions);
  //   submissions.remove(event.submission);
  //   if (submissions.isEmpty)
  //     emit(state.copyWith(flowState: EmptyState(AppStrings.emptySubs)));
  //   emit(state.copyWith(submissions: submissions));
  // }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<FormsState> emit) async {
    Map map = state.valuesMap;
    var newSub = Submission(
        formName: event.formModel.name, fieldEntries: _mapValuesToEntries(map));

    await _assignedFormRepository.addSubmission(newSub);

    emit(state.copyWith(valuesMap: {}));
  }

  Future<void> _onSubmissionUpdated(
      SubmissionUpdated event, Emitter<FormsState> emit) async {
    Map map = state.valuesMap;
    Submission submission = event.submission;
    int index = state.submissions.indexOf(event.submission);
    List<Submission> newSubmissions = List.from(state.submissions);

    Submission newSub =
        submission.copyWith(fieldEntries: _mapValuesToEntries(map));
    // newSubmissions[index] = newSub;
    await _assignedFormRepository.updateSubmission(newSub);

    // emit(state.copyWith(submissions: newSubmissions));
  }

  // Future<void> _onSubmissionsRequested(
  //     SubmissionsRequested event, Emitter<FormsState> emit) async {
  //   final either =
  //       _assignedFormRepository.getFormSubmissions(event.formModel.name);
  //   either.fold((failure) {}, (submissions) {
  //     log(submissions.toString());
  //     if (submissions.isEmpty)
  //       emit(state.copyWith(flowState: LoadingState(stateRendererType: StateRendererType.POPUP_LOADING)));
  //     else {
  //       emit(state.copyWith(
  //           submissions: List.from(submissions), flowState: ContentState()));
  //     }
  //   });
  // }

  //private functions

  Submission _mapValuesToSubmission(Map submissionMap, Submission submission) {
    List<FieldEntry> entries = submissionMap.entries
        .map((e) => FieldEntry(name: e.key, value: e.value))
        .toList();
    submission = submission.copyWith(fieldEntries: entries);

    return submission;
  }

  List<FieldEntry> _mapValuesToEntries(Map submissionMap) {
    List<FieldEntry> entries = submissionMap.entries
        .map((e) => FieldEntry(name: e.key, value: e.value))
        .toList();

    return entries;
  }

  FormFieldModel _getField(FormModel formModel, String fieldName) {
    return formModel.fields.firstWhere((element) => element.name == fieldName);
  }

  List<DropDownModel> _getRelatedDropDowns(
      FormModel formModel, String fieldName) {
    return formModel.fields
        .where((element) => (element is DropDownModel &&
            element.relatedListCheckbox == true &&
            element.relatedListFieldName == fieldName))
        .toList()
        .cast();
  }

  @override
  Future<void> close() {
    log('forms bloc closed');
    return super.close();
  }
}
