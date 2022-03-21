import 'package:flutter/material.dart';
import 'package:form_builder_test/FormValidation.dart';

class DrawEmailTextField extends StatelessWidget with FormValidation {
  const DrawEmailTextField({Key? key, required this.label, required this.required}) : super(key: key);
  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,

      validator: (value){
        if(required)
          if(value!.isEmpty){
            return label+' is required';
          }

         if(!isValidEmail(value!)){
              return 'must be a valid email ';
          }
      },
      decoration: InputDecoration(
          label: Text(label)
      ),
    );
  }
}
