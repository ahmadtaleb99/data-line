
import '../../IDrawable.dart';

import 'package:flutter/material.dart';

class MatrixCheckboxGroupWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return Container();
  }

   MatrixCheckboxGroupWidget({
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
