// ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable
enum Status {initial,loading,success,failure}
class ValidationState {
  Status status;
  DrawCheckboxGroup ? drawCheckboxGroup;
  DrawDropDown ? drawDropDownButton;
  DrawRadioGroup ? radioGroup;

  List<DrawChildList> ? childLists;

  List<FormWidget> ? forms;
  FormWidget ?   form;
  FormModel ?   formModel;



  DrawChildList ? childList;
  List<String>? initialMulti;

  Map<String, FormElement> childsMap;

  ValidationState({
    this.drawCheckboxGroup,
    this.form,
    this.initialMulti ,

    this.formModel,
    this.status = Status.initial,
    this.drawDropDownButton,
    this.radioGroup,
    this.childList,
    this.forms,
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
        childsMap: childsMap ?? this.childsMap,
        forms: forms ?? this.forms,
        formModel: formModel ?? this.formModel,
        initialMulti: initialMulti ?? this.initialMulti
    );
  }

// List<Object?> get props => [formElements,drawCheckboxGroup,radioGroup,childsMap,childLists,drawDropDownButton];


}