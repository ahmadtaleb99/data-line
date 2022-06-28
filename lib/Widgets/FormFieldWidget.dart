import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IDrawable.dart';

class FormFieldWidget<T>  extends StatelessWidget {
  FormFieldWidget({
    Key ? key,
    this.validator,
    required this.visible,
    required this.required,
    required this.widget,
    this.value,


  }) : super(key: key);

  final bool required;
  dynamic value;
  bool?  visible;
  String? Function(T?)? validator;



  final Widget widget;
  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: this.visible == true ?   const EdgeInsets.only(top: 20) :  const EdgeInsets.only(top: 0),
      child:            AnimatedSwitcher(
        transitionBuilder: (Widget child,Animation<double> animation) =>
        SlideTransition(position: Tween<Offset>(
            begin: Offset(0,-1),end: Offset(0,0)
        ).animate(animation),
          child: child,),
    duration: Duration(milliseconds: 400),
    reverseDuration: Duration(milliseconds: 1),

    child:  Visibility(
      visible: visible!,
      maintainSize: false,
      maintainState: false,
      child: FormField<T>(
        autovalidateMode: AutovalidateMode.onUserInteraction,

        validator: validator,
        initialValue: this.value,
        builder: (T){
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget,
              if (T.hasError)
                Padding(
                    padding: const EdgeInsets.only(left: 8, top: 10),
                    child: Text(
                      T.errorText!,
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
    )
    ));
  }

  @override
  String valueToString() {
    // TODO: implement valueToString
    throw UnimplementedError();
  }
}