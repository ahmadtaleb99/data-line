import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/logic/form__bloc.dart';

import 'package:form_builder_test/logic/validation__bloc.dart';

import 'DrawRadioItem.dart';
import 'DrawTextField.dart';

class DrawRadioGroup extends IDrawable {


   DrawRadioGroup({
    Key ? key,
    required this.label,
    required this.name,
     this.visible,
     this.value= null,
    required this.required,
    required this.other,
    required this.children, required this.showIfValueSelected, this.showIfFieldValue,this.showIfIsRequired,
  }) : super(label: label,key: key,
  name: name,
  visible: visible, required: required,
  showIfValueSelected: showIfValueSelected,
  showIfFieldValue: showIfFieldValue,
  showIfIsRequired: showIfIsRequired) ;

   final String label;
    String ? value;
   final String name;
   final bool required;
   final bool other;
   bool ? visible ;
   bool ? isOtherSelected ;
   final List<DrawRadioItem> children;
   final bool  showIfValueSelected;
   final String ? showIfFieldValue;
   final bool ? showIfIsRequired;


  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: this.other == true ?   const EdgeInsets.symmetric(vertical: 0) :  const EdgeInsets.symmetric(vertical: 20),
      child: FormField<String>(
        validator: (value){
          print(this.value.toString()+ ' asdsadasdasd');
          if(this.value == null && required){
            return '$label is required';
          }
        },
        builder: (fieldState) {
          return Column(
            children: [
              BlocBuilder<ValidationBloc, ValidationState>(
                builder: (context, state) {

                  {
                    var children;
                    if (state.radioGroup != null) children = state.radioGroup!.children;

                    {

                      children = this.children;
                    }
                  }
                  return Column(
                    children: [
                      Text(label),
                      ...children,
                      if(isOtherSelected == true)
                        children.last.subTitle = Visibility(
                          maintainSize: false,
                          maintainState: true,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Visibility(
                              visible: isOtherSelected!,
                              child: TextField(
                     ),
                            ),
                          ),
                        )


                    ],
                  );
                },
              ),
          if (fieldState.hasError)
          Padding(
          padding: const EdgeInsets.only(left: 8, top: 10),
          child: Text(
          fieldState.errorText!,
          style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 13,
          color: Colors.red[700],
          height: 0.5),
          ))
            ],
          );
        },
      ),
    );
  }


}
