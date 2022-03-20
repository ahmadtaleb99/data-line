import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../FormValidation.dart';

class DrawTextArea extends StatelessWidget with FormValidation {
  const DrawTextArea({Key? key,required this.minLength,required this.maxLength,required this.label, required this.required}) : super(key: key);
    final int minLength;
    final int maxLength;
    final String label;
    final bool required;
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      onChanged: (description){

      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        if(required && value!.isEmpty)
          return '$label is required';

        return validateTextArea(value!, minLength, maxLength);
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      minLines: minLength,
      maxLines: maxLength,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        counterText: 'asd',
    label:  Text(label),
        contentPadding: EdgeInsets.all(12),
        fillColor: Colors.white,
        filled: true,
        errorStyle: const TextStyle(),
        hintStyle:  TextStyle(
            color: Colors.grey.withOpacity(0.250)
        ),
        enabledBorder: OutlineInputBorder(

            borderSide:  BorderSide(color: Colors.grey.withOpacity(0.250)),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.grey.withOpacity(0.250)),
            borderRadius: BorderRadius.circular(5)),
        errorBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.grey.withOpacity(0.250)),
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
