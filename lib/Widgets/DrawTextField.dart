import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'IDrawable.dart';
class DrawTextField extends  IDrawable {

  DrawTextField({
    required this.label,
    required this.visible,
    required this.required,
    required this.showIfValueSelected,
    required this.showIfFieldValue,
    required this.showIfIsRequired,
  }) : super(label: label,
      visible: visible, required: required,
      showIfValueSelected: showIfValueSelected,
      showIfFieldValue: showIfFieldValue,
      showIfIsRequired: showIfIsRequired) ;

  final String label;
  final bool required;
  bool visible;
  final bool showIfValueSelected;
  final String ? showIfFieldValue;
  final bool ? showIfIsRequired;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return Visibility(
          visible: visible,
          maintainState: true,
          maintainSize: false,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (required || (showIfIsRequired!= null && showIfIsRequired == true)) {
                if (value!.isEmpty) {
                  return label + ' is required';
                }
              }
              else
                return null;
            },
            decoration: InputDecoration(
                label: Text(label)
            ),
          ),
        );
      },
    );
  }


}
