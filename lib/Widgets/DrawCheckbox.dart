import 'package:flutter/material.dart';

class DrawCheckbox extends StatelessWidget {
  const DrawCheckbox({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: false, onChanged: (value){});
  }
}
