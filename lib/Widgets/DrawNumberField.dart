import 'package:flutter/material.dart';
import 'package:form_builder_test/FormValidation.dart';

import '../Expression.dart';

class DrawNumberField extends StatelessWidget with FormValidation {
  const DrawNumberField({Key? key, required this.label, required this.required, required this.expression}) : super(key: key);
  final String label;
  final bool required;
  final Expression expression;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: (number){
        try{
         return validateNumber(int.parse(number!), expression);
        }
        catch (e){
        return 'error';
        }
      },
      decoration: InputDecoration(
          label: Text(label)
      ),
    );
  }
}


