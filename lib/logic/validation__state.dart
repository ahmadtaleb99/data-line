  // ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable
enum Status {initial,loading,success,failure,newFormLoaded}
  class LoadingState {String msg;

  LoadingState.name(this.msg);
}
class ValidationState{

  bool  ? submitted = false;
  Status status;
  DrawCheckboxGroup ? drawCheckboxGroup;
  DrawDropDown ? drawDropDownButton;
  DrawRadioGroup ? radioGroup;
  LoadingState ? loadingState;

  List<DrawChildList> ? childLists;

  List<FormWidget> ? forms;
  List<FormWidget> ? subedForms;
  FormWidget  ?   form;
  FormModel ?   formModel;
  bool ?   islocallyWorking;



  DrawChildList ? childList;
  List<String>? initialMulti;

  Map<String, FormElement> childsMap;

  ValidationState({
    this.drawCheckboxGroup,
    this.form,
    this.initialMulti ,
    this.submitted,
    this.formModel,
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

    DrawCheckboxGroup? drawCheckboxGroup,
    DrawDropDown? drawDropDownButton,
    DrawRadioGroup ? radioGroup,
    List<FormWidget> ? forms,
    FormModel ?   formModel,
    LoadingState ? loadingState,
    List<FormWidget> ? subedForms,

    bool ?   islocallyWorking,
    bool ?   submitted,

    List<DropDownItem>? childItems,
    List<DrawChildList>? childLists,
    DrawChildList? childList,
    Map<String, FormElement> ? childsMap

  }) {
    return ValidationState(
        form: form ?? this.form,
        drawCheckboxGroup: drawCheckboxGroup ?? this.drawCheckboxGroup,
        drawDropDownButton: drawDropDownButton ?? this.drawDropDownButton,
        radioGroup: radioGroup ?? this.radioGroup,
        status: status ?? this.status,
        childLists: childLists ?? this.childLists,
        childList: childList ?? this.childList,
        submitted: submitted ?? this.submitted,
        childsMap: childsMap ?? this.childsMap,
        forms: forms ?? this.forms,
        loadingState: loadingState ?? this.loadingState,
        formModel: formModel ?? this.formModel,
        subedForms: subedForms ?? this.subedForms,
        islocallyWorking: islocallyWorking ?? this.islocallyWorking,
        initialMulti: initialMulti ?? this.initialMulti
    );
  }



}