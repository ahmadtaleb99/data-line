import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'IDrawable.dart';
class DrawTextField extends  FormElementWidget {
  DrawTextField({
    Key ? key,
    required this.label,
    required this.visible,
    required this.required,
    required this.name,
     this.value,
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
  dynamic value;
  bool?  visible;

  final bool showIfValueSelected;
  final String ? showIfFieldValue;
  final bool ? showIfIsRequired;

  @override
  Widget build(BuildContext context) {

    print('value [$value] in text field class ');
    return Padding(

      padding: this.visible == true ?   const EdgeInsets.only(top: 20) :  const EdgeInsets.only(top: 0),
      child: BlocBuilder<ValidationBloc, ValidationState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            transitionBuilder: (Widget child,Animation<double> animation) =>
              SlideTransition(position: Tween<Offset>(
                begin: Offset(0,-1),end: Offset(0,0)
              ).animate(animation),
              child: child,),
            duration: Duration(milliseconds: 400),
              reverseDuration: Duration(milliseconds: 222),

            child: visible! ? TextFormField(
              autocorrect: false,
              initialValue: value,
              onChanged: (value){
                  this.value = value;
               // context.read<ValidationBloc>().add(TextFieldValueChanged(value, textFieldName: this.name));
              },
              autofocus: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (required || (showIfIsRequired!= null && showIfIsRequired == true)) {
                  if (value!.isEmpty) {
                    return label + ' is required';
                  }
                }
                else
                  return null;
              },
              decoration: InputDecoration(
                  label: Text(label)
              ),
            ) : Container()
          );
        },
      ),
    );
  }

  @override
  String valueToString() {
    return this.value.toString();
  }

}
