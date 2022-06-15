import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dynamic form/IFormModel.dart';
import '../../../dynamic form/matrix/fields/MatrixTextField.dart';
import '../../IDrawable.dart';

class MatrixTextFieldWidget extends FormElementWidget {

  IFormModel toModel(){
    return MatrixTextField(name: name, label: label,value: value);
  }

  final String label;
  final String name;
    dynamic value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: (value){
        this.value = value;
      },
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {

          return null;
      },
      decoration: InputDecoration(
          label: Text(label)
      ),
    );
  }

   MatrixTextFieldWidget({
    required this.label,
    required this.name,
    required this.value
  }) : super(label: label,name: name);

  @override
  String valueToString() {
    // TODO: implement valueToString
    throw UnimplementedError();
  }

  MatrixTextFieldWidget copyWith({
    String? label,
    String? name,
    dynamic? value,
  }) {
    return MatrixTextFieldWidget(
      label: label ?? this.label,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }
}
