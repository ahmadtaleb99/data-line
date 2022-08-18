part of 'submissions_bloc.dart';





abstract class SubmissionsEvent extends Equatable {
  const SubmissionsEvent();
}


class SubmissionsRequested extends SubmissionsEvent {
  FormModel formModel;

  SubmissionsRequested(this.formModel,);

  @override
  List<Object?> get props => [formModel];

}

class SubmissionDeleted extends SubmissionsEvent {
  Submission submission;


  SubmissionDeleted(this.submission);
  @override
  List<Object?> get props =>[submission];

}
