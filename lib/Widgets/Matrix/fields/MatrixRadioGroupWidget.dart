import 'package:flutter/cupertino.dart';
import '../../IDrawable.dart';

class MatrixRadioGroupWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return Container();
  }

   MatrixRadioGroupWidget({
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
