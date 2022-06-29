  // ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable
enum Status {initial,loading,success,failure,newFormLoaded}
  class LoadingState {String msg;

  LoadingState(this.msg);
}
class ValidationState{

  bool  ? submitted = false;
  bool  ? updated = false;
  bool   filePicking = false;
  Status status;
  CheckboxGroupWidget ? drawCheckboxGroup;
  DropDownWidget ? drawDropDownButton;
  RadioGroupWidget ? radioGroup;
  LoadingState ? loadingState;

  List<ChildDropDownWidget> ? childLists;

  List<FormWidget> ? forms;
  List<FormWidget> ? subedForms;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  FormWidget  ?   form;
  FormModel ?   formModel;
  bool ?   islocallyWorking;


  ChildDropDownWidget ? childList;
  List<String>? initialMulti;

  Map<String, FormElementWidget> childsMap;

  ValidationState({
    this.drawCheckboxGroup,
    this.form,
    this.initialMulti ,
    this.submitted,
    this.updated,
    this.formModel,
    required this.filePicking,
    this.status = Status.initial,
    this.drawDropDownButton,
    this.radioGroup,
    this.childList,
    this.forms,
    this.loadingState,
    this.subedForms,
    this.islocallyWorking = false,
    required this.childsMap,
    this.childLists = const [],
  });

  ValidationState copyWith({
    FormWidget ?  form,
    Status? status,
    List<String>? initialMulti,

    CheckboxGroupWidget? drawCheckboxGroup,
    DropDownWidget? drawDropDownButton,
    RadioGroupWidget ? radioGroup,
    List<FormWidget> ? forms,
    FormModel ?   formModel,
    LoadingState ? loadingState,
    List<FormWidget> ? subedForms,
    bool  ? filePicking,
    bool ?   islocallyWorking,
    bool ?   submitted,
    bool ?   updated,

    List<DropDownItem>? childItems,
    List<ChildDropDownWidget>? childLists,
    ChildDropDownWidget? childList,
    Map<String, FormElementWidget> ? childsMap

  }) {
    return ValidationState(
        form: form ?? this.form,
        drawCheckboxGroup: drawCheckboxGroup ?? this.drawCheckboxGroup,
        drawDropDownButton: drawDropDownButton ?? this.drawDropDownButton,
        radioGroup: radioGroup ?? this.radioGroup,
        status: status ?? this.status,
        childLists: childLists ?? this.childLists,
        childList: childList ?? this.childList,
        updated: updated ?? this.updated,
        submitted: submitted ?? this.submitted,
        childsMap: childsMap ?? this.childsMap,
        forms: forms ?? this.forms,
        loadingState: loadingState ?? this.loadingState,
        formModel: formModel ?? this.formModel,
        subedForms: subedForms ?? this.subedForms,
        islocallyWorking: islocallyWorking ?? this.islocallyWorking,
        initialMulti: initialMulti ?? this.initialMulti,
        filePicking: filePicking ?? this.filePicking
    );
  }



}