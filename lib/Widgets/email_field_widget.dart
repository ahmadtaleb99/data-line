import 'package:flutter/material.dart';
import 'package:datalines/utils/feild_validation_mixin.dart';
import 'package:datalines/Widgets/form_element_widget.dart';

import '../utils/constants.dart';

class EmailFieldWidget extends FormElementWidget with FormValidation {
   EmailFieldWidget({  Key ? key,
    required this.label,
     this.visible,
     this.value,
     required this.deactivate,
     required this.isHidden,

    required this.required,
    required this.name,
    required this.showIfValueSelected,
    required this.isReadOnly,
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
  final bool deactivate;
  final bool isHidden;
  final bool required;
  final bool isReadOnly;
  bool?  visible;
  final bool showIfValueSelected;
  final String ? showIfFieldValue;
  final bool ? showIfIsRequired;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    print('email visible:'+visible.toString());
    return Padding(
      padding: this.visible == true ?   const EdgeInsets.only(top: 30) :  const EdgeInsets.only(top: 0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        initialValue: value,
        onChanged: (value){
          this.value = value;
        },
        validator: (value){
          if(required)
            if(value!.isEmpty){
              return label+' is required';
            }

           if(!isValidEmail(value!)){
                return 'must be a valid email ';
            }
        },


        decoration: kTextFieldDecoration(label),
      ),
    );
  }


   @override
   String valueToString() {
     return this.value.toString();
   }
}
