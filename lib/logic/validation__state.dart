// ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable

class ValidationState{

  DrawCheckboxGroup ?  drawCheckboxGroup;
  DrawDropDownButton ?  drawDropDownButton;
  List<DropDownItemWidget>  childItems ;
  List<DrawChildList> ?   childLists ;
  DrawChildList ? childList ;
  Map<String,DrawChildList>  childsMap;

  ValidationState({
    this.drawCheckboxGroup,
    this.drawDropDownButton,
    this.childList,
    required this.childsMap ,
    this.childLists  = const [],
      this.childItems = const [],
  });

  ValidationState copyWith({
    DrawCheckboxGroup? drawCheckboxGroup,
    DrawDropDownButton? drawDropDownButton,
    List<DropDownItemWidget>? childItems,
    List<DrawChildList>? childLists,
    DrawChildList? childList,
    Map<String,DrawChildList> ? childsMap

  }) {
    return ValidationState(
      drawCheckboxGroup: drawCheckboxGroup ?? this.drawCheckboxGroup,
      drawDropDownButton: drawDropDownButton ?? this.drawDropDownButton,
      childItems: childItems ?? this.childItems,
      childLists: childLists ?? this.childLists,
      childList: childList ?? this.childList,
      childsMap: childsMap ?? this.childsMap
    );
  }




}
