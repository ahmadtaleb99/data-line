import 'package:flutter/material.dart';

class DrawTextField extends StatelessWidget {
  const DrawTextField({Key? key, required this.label, required this.required}) : super(key: key);
  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      decoration: InputDecoration(
          label: Text(label)
      ),
    );
  }
}
