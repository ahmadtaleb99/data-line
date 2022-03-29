// ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable
enum Status {initial,loading,success,failure}
class ValidationState {
  Status status;
  DrawCheckboxGroup ? drawCheckboxGroup;
  DrawDropDown ? drawDropDownButton;
  DrawRadioGroup ? radioGroup;
  List<DropDownItem> childItems;

  List<DrawChildList> ? childLists;

  List<FormElement> ? formElements;
  DrawChildList ? childList;

  Map<String, FormElement> childsMap;

  ValidationState({
    this.drawCheckboxGroup,
    this.formElements,
    this.status = Status.initial,
    this.drawDropDownButton,
    this.radioGroup,
    this.childList,
    required this.childsMap,
    this.childLists = const [],
    this.childItems = const [],
  });

  ValidationState copyWith({
    List<FormElement>? formElements,
    Status? status,

    DrawCheckboxGroup? drawCheckboxGroup,
    DrawDropDown? drawDropDownButton,
    DrawRadioGroup ? radioGroup,

    List<DropDownItem>? childItems,
    List<DrawChildList>? childLists,
    DrawChildList? childList,
    Map<String, FormElement> ? childsMap

  }) {
    return ValidationState(
        formElements: formElements ?? this.formElements,
        drawCheckboxGroup: drawCheckboxGroup ?? this.drawCheckboxGroup,
        drawDropDownButton: drawDropDownButton ?? this.drawDropDownButton,
        radioGroup: radioGroup ?? this.radioGroup,
        childItems: childItems ?? this.childItems,
        status: status ?? this.status,
        childLists: childLists ?? this.childLists,
        childList: childList ?? this.childList,
        childsMap: childsMap ?? this.childsMap
    );
  }

// List<Object?> get props => [formElements,drawCheckboxGroup,radioGroup,childsMap,childLists,drawDropDownButton];


}