import 'package:flutter/material.dart';
import '../../IDrawable.dart';

class MatrixCheckboxWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return Container();
  }

   MatrixCheckboxWidget({
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
