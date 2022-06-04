import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/FormValidation.dart';
import 'package:form_builder_test/Widgets/FormFieldWidget.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';

import '../Expression.dart';

class DrawNumberField extends FormElementWidget with FormValidation {
   DrawNumberField(
      {Key? key,
        required this.label,
         this.visible,
         this.value,
        required this.required,
        required this.name,
        required this.showIfValueSelected,
        required this.showIfFieldValue,
        required this.showIfIsRequired,
      required this.expression})
      :  super(label: label,key: key,
      name: name,
      visible: visible, required: required,
      showIfValueSelected: showIfValueSelected,
      showIfFieldValue: showIfFieldValue,
      showIfIsRequired: showIfIsRequired) ;

  final String label;
  final String name;
  final bool required;
  bool  ? visible;
  final bool showIfValueSelected;
  final String? showIfFieldValue;
  final bool? showIfIsRequired;
  dynamic value;
  final Expression expression;

  @override
  Widget build(BuildContext context) {
    return FormFieldWidget(
      visible: visible,
     required: required,
     widget :TextFormField(
        initialValue: value,
        onChanged: (value){
          this.value = value;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,
        validator: (number) {
          try {
            if (number!.isEmpty) return 'required';

            return validateNumber(int.parse(number), expression);
          } catch (e) {
            return 'must be a number';
          }
        },
        decoration: InputDecoration(label: Text(label)),
      ),
    );
  }


   @override
   String valueToString() {
     return this.value.toString();
   }
}
