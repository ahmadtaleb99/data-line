part of 'forms_bloc.dart';

// values map
//the value of every field in the form, the key is the field name,
// the value's type differs among fields,
// checkboxgroup  and multi select drop down values are Lists of Strings,

enum MatrixStatus{error,success}

class MatrixState{

 final String msg;
 final MatrixStatus status;

  MatrixState(this.status, this.msg);




}
class   FormsState extends Equatable {
  final   Submission? currentSubmission;
  final   FormModel? formModel;
  final  List<Submission> submissions;
  final Map<String,dynamic> valuesMap;
  final bool isNewSubmit;
  final FlowState flowState;
  final FlowState newFlowState;
  final FlowState updateFlowState;
  final  List<FormModel> assignedForms;
  final MatrixState? matrixState;
  final Map<String,bool> validationMap;
  final Map<String,bool> isFilePicking;
  final int? currentRecordIndex ;
  final String? currentMatrixName;
  final MatrixRecordModel? tempRecord;
  final bool allSaved;
  final Map<String,List<MatrixRecordModel>> matrixValuesMap;


  @override
  List<Object?> get props => [isNewSubmit,updateFlowState,matrixState,tempRecord,currentMatrixName,currentRecordIndex,matrixValuesMap,allSaved,newFlowState,valuesMap,submissions,isFilePicking,formModel,currentSubmission,flowState,assignedForms,validationMap];

  const FormsState({
    this.formModel,
    this.currentSubmission,
    required this.isNewSubmit,
    required this.valuesMap,
    required this.matrixValuesMap,
     this.currentRecordIndex,
     this.matrixState,
     this.currentMatrixName,
    required this.validationMap,
    required this.submissions,
       this.tempRecord,
    required this.flowState,
    required this.newFlowState,
    required this.updateFlowState,
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
    bool? isNewSubmit,
    FlowState? newSubmitFlowState,
    FlowState? updateFlowState,

    List<FormModel>? assignedForms,
    MatrixState? matrixState,
    ValueGetter<MatrixRecordModel?>? tempRecord, //in order to give copyWith method null value
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
      updateFlowState: updateFlowState ?? this.updateFlowState,
      currentRecordIndex: currentRecordIndex ?? this.currentRecordIndex,
      currentMatrixName: currentMatrix ?? this.currentMatrixName,
      isNewSubmit: isNewSubmit ?? this.isNewSubmit,
      currentSubmission: currentSubmission ?? this.currentSubmission,
      tempRecord: tempRecord != null ? tempRecord() : this.tempRecord,
      flowState: flowState ?? this.flowState,
      newFlowState: newSubmitFlowState ?? this.newFlowState,
      assignedForms: assignedForms ?? this.assignedForms,
      matrixState: matrixState ?? this.matrixState,
      allSaved: allSaved ?? this.allSaved,
    );
  }
}
