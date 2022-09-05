part of 'forms_bloc.dart';

// values map
//the value of every field in the form, the key is the field name,
// the value's type differs among fields,
// checkboxgroup  and multi select drop down values are Lists of Strings,




class   FormsState extends Equatable {
  final   Submission? currentSubmission;
  final   FormModel? formModel;
  final  List<Submission> submissions;
  final Map<String,dynamic> valuesMap;
  final FlowState flowState;
  final FlowState newFlowState;
  final  List<FormModel> assignedForms;
  final Map<String,bool> validationMap;
  final Map<String,bool> isFilePicking;
  final int? currentRecordIndex ;
  final String? currentMatrixName;
  final MatrixRecordModel? tempRecord;
  final bool allSaved;
  final Map<String,List<MatrixRecordModel>> matrixValuesMap;


  @override
  List<Object?> get props => [tempRecord,currentMatrixName,currentRecordIndex,matrixValuesMap,allSaved,newFlowState,valuesMap,submissions,isFilePicking,formModel,currentSubmission,flowState,assignedForms,validationMap];

  const FormsState({
    this.formModel,
    this.currentSubmission,
    required this.valuesMap,
    required this.matrixValuesMap,
     this.currentRecordIndex,
     this.currentMatrixName,
    required this.validationMap,
    required this.submissions,
     this.tempRecord,
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
    MatrixRecordModel? tempRecord,
    Map<String,bool>? validationMap,
     int? currentRecordIndex ,
     String? currentMatrix ,
    Map<String,bool>? isFilePicking,
    Map<String,List<MatrixRecordModel>> ? matrixValuesMap,
    bool? allSaved
  }) {
    return FormsState(
      formModel: formModel ?? this.formModel,
      matrixValuesMap: matrixValuesMap ?? this.matrixValuesMap,
      valuesMap: valuesMap ?? this.valuesMap,
      validationMap: validationMap ?? this.validationMap,
      isFilePicking: isFilePicking ?? this.isFilePicking,
      submissions: submissions ?? this.submissions,
      currentRecordIndex: currentRecordIndex ?? this.currentRecordIndex,
      currentMatrixName: currentMatrix ?? this.currentMatrixName,
      currentSubmission: currentSubmission ?? this.currentSubmission,
      tempRecord: tempRecord ?? this.tempRecord,
      flowState: flowState ?? this.flowState,
      newFlowState: newSubmitFlowState ?? this.newFlowState,
      assignedForms: assignedForms ?? this.assignedForms,
      allSaved: allSaved ?? this.allSaved,
    );
  }
}
