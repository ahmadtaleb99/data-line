import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';

class DrawForm extends FormElement{

  bool validate(){
    _key.currentState!.reset();
    return _key.currentState!.validate();
  }
  final String label;
  final String name;
  final List<FormElement> fields;

  DrawForm({
    required this.label,
    required this.name,
    required this.fields,
  }) : super(label: label, name: name) ;




  GlobalKey<FormState> _key = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return Form(
      key: _key,
      child:  Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                children: this.fields,
              ),
      )  );
          }
  }


