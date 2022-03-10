import 'package:flutter/material.dart';

class DrawCheckboxGroup extends StatelessWidget {
  const DrawCheckboxGroup({Key? key, required this.children, required this.label}) : super(key: key);
  final List <Widget>  children;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(label),
      SizedBox(height: 10,),
      Column(children: children)
    ],);
  }
}
