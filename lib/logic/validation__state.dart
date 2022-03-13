// ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable

class ValidationState   {

  DrawCheckboxGroup ?  drawCheckboxGroup;
  bool ?  isChecked = false;


  ValidationState({
     this.drawCheckboxGroup, this.isChecked
  });

  ValidationState copyWith({
    DrawCheckboxGroup? drawCheckboxGroup,
    bool? isChecked,
  }) {
    return ValidationState(
      drawCheckboxGroup: drawCheckboxGroup ?? this.drawCheckboxGroup,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  // @override
  // // TODO: implement props
  // List<Object?> get props => [drawCheckboxGroup];
}
