import 'package:flutter/material.dart';

import 'IDrawable.dart';

class FormFieldWidget  extends FormElementWidget {
  FormFieldWidget({required String label, required String name}) : super(label: label, name: name);


  @override
  Widget build(BuildContext context) {

    print('value [$value] in text field class ');
    return Padding(

      padding: this.visible == true ?   const EdgeInsets.only(top: 20) :  const EdgeInsets.only(top: 0),
      child:            AnimatedSwitcher(
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
    )
    ,
    );
  }

  @override
  String valueToString() {
    // TODO: implement valueToString
    throw UnimplementedError();
  }
}