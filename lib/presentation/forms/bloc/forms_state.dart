part of 'forms_bloc.dart';




class FormsState extends Equatable {
  final   Submission? currentSubmission;
  final   FormModel? formModel;
  final  List<Submission> submissions;
  final Map<String,dynamic> submissionMap;
  @override
  List<Object?> get props => [submissionMap,submissions,formModel,currentSubmission];

  const FormsState({
    this.formModel,
    this.currentSubmission,
    required this.submissionMap,
    required this.submissions,
  });

  FormsState copyWith({
    FormModel? formModel,
    Map<String, dynamic>? submissionMap,
    List<Submission>? submissions,
    Submission? currentSubmission
  }) {
    return FormsState(
      formModel: formModel ?? this.formModel,
      submissionMap: submissionMap ?? this.submissionMap,
      submissions: submissions ?? this.submissions,
      currentSubmission: currentSubmission ?? this.currentSubmission,
    );
  }
}
