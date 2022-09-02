part of 'forms_bloc.dart';

// values map
//the value of every field in the form, the key is the field name,
// the value's type differs among fields,
// checkboxgroup  and multi select drop down values are Lists of Strings,




class FormsState extends Equatable {
  final   Submission? currentSubmission;
  final   FormModel? formModel;
  final  List<Submission> submissions;
  final Map<String,dynamic> valuesMap;
  final FlowState flowState;
  final FlowState newFlowState;
  final  List<FormModel> assignedForms;
  final Map<String,bool> validationMap;
  final Map<String,bool> isFilePicking;
  final bool allSaved;

  @override
  List<Object?> get props => [allSaved,newFlowState,valuesMap,submissions,isFilePicking,formModel,currentSubmission,flowState,assignedForms,validationMap];

  const FormsState({
    this.formModel,
    this.currentSubmission,
    required this.valuesMap,
    required this.validationMap,
    required this.submissions,
    required this.flowState,
    required this.newFlowState,
    required this.isFilePicking,
    required this.allSaved,
    required this.assignedForms,

  });

  FormsState copyWith({
    FormModel? formModel,
    Map<String, dynamic>? valuesMap,
    List<Submission>? submissions,
    Submission? currentSubmission,
    FlowState? flowState,
    FlowState? newSubmitFlowState,
    List<FormModel>? assignedForms,
    Map<String,bool>? validationMap,
    Map<String,bool>? isFilePicking,
    bool? allSaved
  }) {
    return FormsState(
      formModel: formModel ?? this.formModel,
      valuesMap: valuesMap ?? this.valuesMap,
      validationMap: validationMap ?? this.validationMap,
      isFilePicking: isFilePicking ?? this.isFilePicking,
      submissions: submissions ?? this.submissions,
      currentSubmission: currentSubmission ?? this.currentSubmission,
      flowState: flowState ?? this.flowState,
      newFlowState: newSubmitFlowState ?? this.newFlowState,
      assignedForms: assignedForms ?? this.assignedForms,
      allSaved: allSaved ?? this.allSaved,
    );
  }
}
