import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/dynamic%20form/IFormCheckBoxGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormNumber.dart';
import 'package:form_builder_test/dynamic%20form/IFormTextArea.dart';

import 'constants.dart';
import 'dynamic form/IFormDropList.dart';
import 'dynamic form/IFormEmail.dart';
import 'dynamic form/IFormTextField.dart';
import 'dynamic form/formable.dart';

class FormRepository {


  List<IForm> _jsonSerialize()  {
    List<IForm> itemsToDraw = [];
    var data = jsonDecode(rawJson);
    for(var formElement in data ){
      var type  = _htmlFormToFlutters(formElement['type']);
      type!.setParameters(formElement);
      itemsToDraw.add(type);
    }

    return itemsToDraw;
  }



  Future<List<Widget>> getFormElements() async {
    await Future.delayed(Duration(seconds: 2));
    var list = _jsonSerialize().
    return;
  }
  IForm ? _htmlFormToFlutters(String type){
    switch (type){
      case 'select':
        return IFormDropList();
      case 'text':
        return IFormTextField();

      case 'textarea':
        return IFormTextArea();
      case 'number':
        return IFormNumber();

      case 'email':
        return IFormEmail();

      case 'checkbox-group':
        return IFormCheckBoxGroup();
      default :  return null;
    }


}}