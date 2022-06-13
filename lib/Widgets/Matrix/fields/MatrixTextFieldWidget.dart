import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../IDrawable.dart';

class MatrixTextFieldWidget extends FormElementWidget {

  final String label;
  final String name;
    dynamic value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value){
      },
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
          if (value!.isEmpty) {
            return label + ' is required';
          }
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
}
