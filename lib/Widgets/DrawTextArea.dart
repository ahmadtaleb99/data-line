import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawTextArea extends StatelessWidget {
  const DrawTextArea({Key? key,required this.minLength,required this.maxLength,required this.label}) : super(key: key);
    final int minLength;
    final int maxLength;
    final String label;
  @override
  Widget build(BuildContext context) {
    return   TextField(
      onChanged: (description){

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
