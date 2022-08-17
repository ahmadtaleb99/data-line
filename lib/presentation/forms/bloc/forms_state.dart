part of 'forms_bloc.dart';




class FormsState extends Equatable {
  final   Submission? currentSubmission;
  final   FormModel? formModel;
  final  List<Submission> submissions;
  final Map<String,dynamic> valuesMap;
  final FlowState flowState;
  final  List<FormModel> assignedForms;

  @override
  List<Object?> get props => [valuesMap,submissions,formModel,currentSubmission,flowState,assignedForms];

  const FormsState({
    this.formModel,
    this.currentSubmission,
    required this.valuesMap,
    required this.submissions,
    required this.flowState,
    required this.assignedForms,
  });

  FormsState copyWith({
    FormModel? formModel,
    Map<String, dynamic>? valuesMap,
    List<Submission>? submissions,
    Submission? currentSubmission,
    FlowState? flowState,
    List<FormModel>? assignedForms
  }) {
    return FormsState(
      formModel: formModel ?? this.formModel,
      valuesMap: valuesMap ?? this.valuesMap,
      submissions: submissions ?? this.submissions,
      currentSubmission: currentSubmission ?? this.currentSubmission,
      flowState: flowState ?? this.flowState,
      assignedForms: assignedForms ?? this.assignedForms,
    );
  }
}
