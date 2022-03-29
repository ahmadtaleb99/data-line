import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/Widgets/DrawMultiSelect.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormCheckBoxGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormDrawRadioGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormFilePicker.dart';
import 'package:form_builder_test/dynamic%20form/IFormNumber.dart';
import 'package:form_builder_test/dynamic%20form/IFormTextArea.dart';

import 'Widgets/DrawChecboxGroup.dart';
import 'Widgets/DrawRadioGroup.dart';
import 'constants.dart';
import 'dynamic form/IFormDropList.dart';
import 'dynamic form/IFormEmail.dart';
import 'dynamic form/IFormTextField.dart';
import 'dynamic form/formable.dart';

class FormRepository {

  List<FormElement> _formElementList = [];

  List<FormElement> get formElementList => _formElementList;

  List<IFormModel> _jsonSerialize(int formID)  {
    List<IFormModel> itemsToDraw = [];
    var data ;
    if(formID == 0)
  data = jsonDecode(rawJson);
    else if (formID == 1)
       data = jsonDecode(rawJson1);
    for(var formElement in data ){
      var type  = _htmlFormToFlutters(formElement['type']);
      type!.setParameters(formElement);
      itemsToDraw.add(type);

    }

    return itemsToDraw;
  }



  Future<List<FormElement>> LoadFormElements(int formId) async {
    this._formElementList = [];
    await Future.delayed(Duration(seconds: 1));
    for(var element in _jsonSerialize(formId)){
      print(element);
      this._formElementList.add(element.formElementFromJson()) ;
    }

    return _formElementList;
  }

  DrawCheckboxGroup getCheckBoxGroup (String name) {

    return _formElementList.firstWhere((element) => (element is DrawCheckboxGroup) && element.name == name) as DrawCheckboxGroup;
  }

  DrawRadioGroup getRadioGroup (String name) {

    return _formElementList.firstWhere((element) => (element is DrawRadioGroup) && element.name == name) as DrawRadioGroup;
  }


  List<FormElement> getChildrenSelectsFor (String name) {

    return _formElementList.where((dynamic element) =>(  (element is DrawChildList)  ||  (element is DrawMultiSelect ) ) &&  (  element.parentName == name)).toList().cast()  ;
  }



  IFormModel ? _htmlFormToFlutters(String type){
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

      case 'radio-group':
        return IFormDrawRadioGroup();

      case 'file':
        return IFormFilePicker();

      case 'checkbox-group':
        return IFormCheckBoxGroup();
      default :  return null;
    }


}

}