import 'package:flutter/material.dart';
import '../../IDrawable.dart';


class MatrixNumberWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      autovalidateMode: AutovalidateMode.onUserInteraction  ,
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

  MatrixNumberWidget copyWith({
    String? label,
    String? name,
    dynamic? value,
  }) {
    return MatrixNumberWidget(
      label: label ?? this.label,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }
}
