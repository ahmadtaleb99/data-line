import 'package:flutter/material.dart';
import '../../IDrawable.dart';

class MatrixDropDownWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;
  final  List<DropdownMenuItem<String>> ?  values;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 10),
          child: Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        DropdownButton<String>(items: values, onChanged:(value)  {


        },value: value,),
      ],
    );
  }

   MatrixDropDownWidget({
    required this.label,
    required this.name,
    required this.value,
    required this.values
   }) : super(label: label,name: name);

  @override
  String valueToString() {
    // TODO: implement valueToString
    throw UnimplementedError();
  }
}
