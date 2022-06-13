import 'package:flutter/material.dart';
import '../../IDrawable.dart';


class MatrixNumberWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      autovalidateMode: AutovalidateMode.always,
      validator: (value) {
        try {
          if (value!.isEmpty) return 'required';

        } catch (e) {
          return 'must be a number';
        }
      },
      decoration: InputDecoration(
          label: Text(label)
      ),
    );
  }



   MatrixNumberWidget({
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
