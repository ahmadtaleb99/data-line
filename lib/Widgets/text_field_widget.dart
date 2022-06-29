import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/form_field_widget.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import '../utils/constants.dart';
import 'form_element_widget.dart';
class TextFieldWidget extends  FormElementWidget {
  TextFieldWidget({
    Key ? key,
    required this.label,
    required this.visible,
    required this.required,
    required this.name,
     this.value,
    required this.showIfValueSelected,
    required this.showIfFieldValue,
    required this.showIfIsRequired,
  }) : super(label: label,key: key,
      name: name,
      visible: visible, required: required,
      showIfValueSelected: showIfValueSelected,
      showIfFieldValue: showIfFieldValue,
      showIfIsRequired: showIfIsRequired) ;

  final String label;
  final String name;
  final bool required;
  dynamic value;
  bool?  visible;

  final bool showIfValueSelected;
  final String ? showIfFieldValue;
  final bool ? showIfIsRequired;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return FormFieldWidget(
     visible: visible, required: required,
            widget: TextFormField(
          autocorrect: false,
          initialValue: value,
          onChanged: (value){
            this.value = value;
            // context.read<ValidationBloc>().add(TextFieldValueChanged(value, textFieldName: this.name));
          },
          autofocus: false,
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
          decoration: kTextFieldDecoration(label),
        ));
      },
    );
  }

  @override
  String valueToString() {
    return this.value.toString();
  }

}
