import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/dynamic%20form/IFormCheckBoxGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormNumber.dart';
import 'package:form_builder_test/dynamic%20form/IFormTextArea.dart';

import 'Widgets/DrawChecboxGroup.dart';
import 'constants.dart';
import 'dynamic form/IFormDropList.dart';
import 'dynamic form/IFormEmail.dart';
import 'dynamic form/IFormTextField.dart';
import 'dynamic form/formable.dart';

class FormRepository {

  List<Widget> _formElementList = [];

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
    for(var element in _jsonSerialize()){
      this._formElementList.add(element.drawFormElement()) ;
    }

    return _formElementList;
  }

  DrawCheckboxGroup getCheckBoxGroup (String name) {

    return _formElementList.firstWhere((element) => (element is DrawCheckboxGroup) && element.name == name) as DrawCheckboxGroup;
  }


  List<DrawDropDownButton> getChildDropDowns (String name) {

    return _formElementList.where((element) => element is DrawDropDownButton && element.parentName == name) as List<DrawDropDownButton> ;
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