// ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable

class ValidationState{

  DrawCheckboxGroup ?  drawCheckboxGroup;
  DrawDropDownButton ?  drawDropDownButton;
  List<DropDownItemWidget>  childItems ;
  List<DrawChildList> ?   childLists ;
  DrawChildList ? childList ;


  ValidationState({
    this.drawCheckboxGroup,
    this.drawDropDownButton,
    this.childList,
    this.childLists  = const [],
      this.childItems = const [],
  });

  ValidationState copyWith({
    DrawCheckboxGroup? drawCheckboxGroup,
    DrawDropDownButton? drawDropDownButton,
    List<DropDownItemWidget>? childItems,
    List<DrawChildList>? childLists,
    DrawChildList? childList,
  }) {
    return ValidationState(
      drawCheckboxGroup: drawCheckboxGroup ?? this.drawCheckboxGroup,
      drawDropDownButton: drawDropDownButton ?? this.drawDropDownButton,
      childItems: childItems ?? this.childItems,
      childLists: childLists ?? this.childLists,
      childList: childList ?? this.childList,
    );
  }




}
