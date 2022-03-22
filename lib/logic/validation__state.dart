// ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable

class ValidationState{

  DrawCheckboxGroup ?  drawCheckboxGroup;
  DrawDropDownButton ?  drawDropDownButton;
  DrawRadioGroup  ? radioGroup;
  List<DropDownItemWidget>  childItems ;
  List<DrawChildList> ?   childLists ;
  List ? formElements;
  DrawChildList ? childList ;
  Map<String,DrawChildList>  childsMap;

  ValidationState({
    this.drawCheckboxGroup,
    this.formElements,
    this.drawDropDownButton,
    this.radioGroup,
    this.childList,
    required this.childsMap ,
    this.childLists  = const [],
      this.childItems = const [],
  });

  ValidationState copyWith({
    List? formElements,

    DrawCheckboxGroup? drawCheckboxGroup,
    DrawDropDownButton? drawDropDownButton,
    DrawRadioGroup  ? radioGroup,

    List<DropDownItemWidget>? childItems,
    List<DrawChildList>?  childLists,
    DrawChildList? childList,
    Map<String,DrawChildList> ? childsMap

  }) {
    return ValidationState(
      formElements: formElements ?? this.formElements,
      drawCheckboxGroup: drawCheckboxGroup ?? this.drawCheckboxGroup,
      drawDropDownButton: drawDropDownButton ?? this.drawDropDownButton,
        radioGroup: radioGroup ?? this.radioGroup,
        childItems: childItems ?? this.childItems,
      childLists: childLists ?? this.childLists,
      childList: childList ?? this.childList,
      childsMap: childsMap ?? this.childsMap
    );
  }




}
