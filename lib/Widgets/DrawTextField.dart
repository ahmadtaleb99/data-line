import 'package:flutter/material.dart';
import 'IDrawable.dart';

class DrawTextField extends StatelessWidget  implements IDrawable{

   DrawTextField({
    required this.label,
    required this.visible,
    required this.required,
    required this.showIfValueSelected,
    required this.showIfFieldValue,
    required this.showIfIsRequired,
  });
  final String label;
  final bool required;
   bool visible;
  final bool  showIfValueSelected;
  final String ? showIfFieldValue;
  final bool ?  showIfIsRequired;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainState: true,
      maintainSize: false,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value){
          if(required) {

            if(value!.isEmpty){
              return label+' is required';
            }
          }
          else return null;
        },
        decoration: InputDecoration(
            label: Text(label)
        ),
      ),
    );
  }

  

}
