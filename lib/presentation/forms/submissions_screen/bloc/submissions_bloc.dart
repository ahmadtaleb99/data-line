import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/services/io/FileCachingService.dart';

import '../../../../domain/repository/form_repository.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';

part 'submissions_event.dart';
part 'submissions_state.dart';

class SubmissionsBloc extends Bloc<SubmissionsEvent, SubmissionsState> {
  final AssignedFormRepository _assignedFormRepository;
  final _ioService = getIt<FileCachingService>();

    SubmissionsBloc(this._assignedFormRepository) : super(SubmissionsState(flowState: ContentState(),submissions: [])) {
    on<SubmissionsRequested>(_onSubmissionsRequested);
    on<SubmissionDeleted>(_onSubmissionDeleted);

  }



  Future<void> _onSubmissionsRequested(
      SubmissionsRequested event, Emitter<SubmissionsState> emit) async {
    final either =
    _assignedFormRepository.getFormSubmissions(event.formModel.id);
    either.fold((failure) {}, (submissions) {
     submissions.forEach((element) {
       log(element.id.toString() +' sub id : : ');
     });
      if (submissions.isEmpty)
        emit(state.copyWith(flowState: EmptyState(AppStrings.emptySubs)));
      else {

        submissions.forEach((element) {log(element.id.toString());});
        emit(state.copyWith(
            submissions: List.from(submissions), flowState: ContentState()));
      }
    });
  }

Future<void> _onSubmissionDeleted(
    SubmissionDeleted event, Emitter<SubmissionsState> emit) async {
  Map<String, dynamic> map = {};
  await _assignedFormRepository.deleteSubmission(event.submission);
  await _ioService.deleteSubmissionCache('/${event.submission.id}-${event.submission.formId}');

  List<Submission> submissions = List.from(state.submissions);
  submissions.remove(event.submission);
  if (submissions.isEmpty)
    emit(state.copyWith(flowState: EmptyState(AppStrings.emptySubs)));
  emit(state.copyWith(submissions: submissions));
}
}
