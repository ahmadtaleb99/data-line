// ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable

class ValidationState    {

  DrawCheckboxGroup ?  drawCheckboxGroup;
  DrawDropDownButton ?  drawDropDownButton;
  List<DropDownItemWidget>  childItems ;


  ValidationState({
    this.drawCheckboxGroup,
    this.drawDropDownButton,
      this.childItems = const [DropDownItemWidget(value: '', status: '')],
  });

  ValidationState copyWith({
    DrawCheckboxGroup? drawCheckboxGroup,
    DrawDropDownButton? drawDropDownButton,
    bool? isChecked,
    List<DropDownItemWidget>? childItems,
  }) {
    return ValidationState(
      drawCheckboxGroup: drawCheckboxGroup ?? this.drawCheckboxGroup,
      drawDropDownButton: drawDropDownButton ?? this.drawDropDownButton,
      childItems: childItems ?? this.childItems,
    );
  }
}
