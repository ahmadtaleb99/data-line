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
  final List<Node> nodes;
  final Map<String,dynamic> valuesMap;
  final bool isNewSubmit;
  final FlowState flowState;
  final FlowState newFlowState;
  final FlowState updateFlowState;
  final  List<FormModel> assignedForms;
  final  List<FormModel> inactiveForms;
  final MatrixState? matrixState;
  final Map<String,bool> validationMap;
  final Map<String,bool> isFilePicking;
  final int? currentRecordIndex ;
  final String? currentMatrixName;
  final Node? currentNode;
  final MatrixRecordModel? tempRecord;
  final bool allSaved;
  final bool isFormSyncing;
  final Map<String,bool> formHasSubmissions;
  final  SyncFormProgress syncFormProgress;
  final Map<String,List<MatrixRecordModel>> matrixValuesMap;


  @override
  List<Object?> get props => [formHasSubmissions,syncFormProgress,isFormSyncing,inactiveForms,currentNode,nodes,isNewSubmit,updateFlowState,matrixState,tempRecord,currentMatrixName,currentRecordIndex,matrixValuesMap,allSaved,newFlowState,valuesMap,submissions,isFilePicking,formModel,currentSubmission,flowState,assignedForms,validationMap];

  const FormsState({
    this.formModel,
    this.currentSubmission,
    required this.isNewSubmit,
     this.syncFormProgress = const SyncFormProgress(submissionsChunksProgress:0, submissionUploadProgress: 0,requiresUploadProgress: false),
    required this.currentNode,
    required this.valuesMap,
    required this.formHasSubmissions,
    required this.matrixValuesMap,
    required this.nodes,
     this.currentRecordIndex,
     this.matrixState,
     this.isFormSyncing = false,
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
    required this.inactiveForms,

  });

  FormsState copyWith({
    FormModel? formModel,
    Map<String, dynamic>? valuesMap,
    List<Submission>? submissions,
    Submission? currentSubmission,
    FlowState? flowState,
    bool? isNewSubmit,
    bool? isFormSyncing,
    FlowState? newSubmitFlowState,
    FlowState? updateFlowState,

    List<FormModel>? assignedForms,
    Map<String,bool>? formHasSubmissions,
    SyncFormProgress? syncFormProgress,
    List<FormModel>? inactiveForms,
    List<Node>? nodes,
    MatrixState? matrixState,
    ValueGetter<Node?>? currentNode,
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
      formHasSubmissions: formHasSubmissions ?? this.formHasSubmissions,
      valuesMap: valuesMap ?? this.valuesMap,
      validationMap: validationMap ?? this.validationMap,
      isFilePicking: isFilePicking ?? this.isFilePicking,
      submissions: submissions ?? this.submissions,
      updateFlowState: updateFlowState ?? this.updateFlowState,
      currentRecordIndex: currentRecordIndex ?? this.currentRecordIndex,
      syncFormProgress: syncFormProgress ?? this.syncFormProgress,
      currentMatrixName: currentMatrix ?? this.currentMatrixName,
      isNewSubmit: isNewSubmit ?? this.isNewSubmit,
      isFormSyncing: isFormSyncing ?? this.isFormSyncing,
      currentSubmission: currentSubmission ?? this.currentSubmission,
      tempRecord: tempRecord != null ? tempRecord() : this.tempRecord,
      currentNode:  currentNode != null ? currentNode() : this.currentNode,
      flowState: flowState ?? this.flowState,
      newFlowState: newSubmitFlowState ?? this.newFlowState,
      assignedForms: assignedForms ?? this.assignedForms,
      inactiveForms: inactiveForms ?? this.inactiveForms,
      nodes: nodes ?? this.nodes,
      matrixState: matrixState ?? this.matrixState,
      allSaved: allSaved ?? this.allSaved,
    );
  }
}
