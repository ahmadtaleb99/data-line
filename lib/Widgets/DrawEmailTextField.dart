import 'package:flutter/material.dart';

class DrawEmailTextField extends StatelessWidget {
  const DrawEmailTextField({Key? key, required this.label, required this.required}) : super(key: key);
  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(required)
          if(value == null){
            return label+' is required';
          }
      },
      decoration: InputDecoration(
          label: Text(label)
      ),
    );
  }
}
