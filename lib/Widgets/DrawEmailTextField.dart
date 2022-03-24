import 'package:flutter/material.dart';
import 'package:form_builder_test/FormValidation.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';

class DrawEmailTextField extends IDrawable with FormValidation {
   DrawEmailTextField({  Key ? key,
    required this.label,
     this.visible,
    required this.required,
    required this.name,
    required this.showIfValueSelected,
    required this.showIfFieldValue,
    required this.showIfIsRequired,
  }) : super(label: label,key: key,
      name: name,
      visible: visible, required: required,
      showIfValueSelected: showIfValueSelected,
      showIfFieldValue: showIfFieldValue,
      showIfIsRequired: showIfIsRequired) ;



  final String label;
  final String name;
  final bool required;
  bool?  visible;
  final bool showIfValueSelected;
  final String ? showIfFieldValue;
  final bool ? showIfIsRequired;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.visible == true ?   const EdgeInsets.only(top: 30) :  const EdgeInsets.only(top: 0),
      child: TextFormField(
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
      ),
    );
  }
}
