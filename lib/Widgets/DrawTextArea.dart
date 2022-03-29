import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';

import '../FormValidation.dart';

class DrawTextArea extends FormElement with FormValidation {
   DrawTextArea(
      {Key ? key,
        required this.label,
         this.visible,
        required this.required,
        required this.name,
        required this.showIfValueSelected,
        required this.showIfFieldValue,
        required this.showIfIsRequired,
        required this.minLength , required this.maxLength
      }) : super(label: label,key: key,
      name: name,
      visible: visible, required: required,
      showIfValueSelected: showIfValueSelected,
      showIfFieldValue: showIfFieldValue,
      showIfIsRequired: showIfIsRequired) ;


  final int minLength;
  final int maxLength;
  final String label;
  final String name;
  final bool required;
  bool? visible;
  final bool showIfValueSelected;
  final String? showIfFieldValue;
  final bool? showIfIsRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.visible == true ?   const EdgeInsets.only(top: 40) :  const EdgeInsets.only(top: 0),
      child: TextFormField(
        onChanged: (description) {},
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (required && value!.isEmpty) return '$label is required';

          return validateTextArea(value!, minLength, maxLength);
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
        minLines: minLength,
        maxLines: maxLength,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          label: Text(label),
          contentPadding: EdgeInsets.all(12),
          fillColor: Colors.white,
          filled: true,
          errorStyle: const TextStyle(),
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.250)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.250)),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.250)),
              borderRadius: BorderRadius.circular(5)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.250)),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
