import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

import '../../../../domain/repository/form_repository.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';

part 'submissions_event.dart';
part 'submissions_state.dart';

class SubmissionsBloc extends Bloc<SubmissionsEvent, SubmissionsState> {
  final AssignedFormRepository _assignedFormRepository;

    SubmissionsBloc(this._assignedFormRepository) : super(SubmissionsState(flowState: ContentState(),submissions: [])) {
    on<SubmissionsRequested>(_onSubmissionsRequested);
    on<SubmissionDeleted>(_onSubmissionDeleted);

  }



  Future<void> _onSubmissionsRequested(
      SubmissionsRequested event, Emitter<SubmissionsState> emit) async {
    final either =
    _assignedFormRepository.getFormSubmissions(event.formModel.name);
    either.fold((failure) {}, (submissions) {
      log(submissions.toString());
      if (submissions.isEmpty)
        emit(state.copyWith(flowState: EmptyState(AppStrings.emptySubs)));
      else {
        emit(state.copyWith(
            submissions: List.from(submissions), flowState: ContentState()));
      }
    });
  }

Future<void> _onSubmissionDeleted(
    SubmissionDeleted event, Emitter<SubmissionsState> emit) async {
  Map<String, dynamic> map = {};
  await _assignedFormRepository.deleteSubmission(event.submission);
  List<Submission> submissions = List.from(state.submissions);
  submissions.remove(event.submission);
  if (submissions.isEmpty)
    emit(state.copyWith(flowState: EmptyState(AppStrings.emptySubs)));
  emit(state.copyWith(submissions: submissions));
}
}