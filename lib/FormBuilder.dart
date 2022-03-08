import 'dart:convert';

import 'constants.dart';
import 'dynamic form/IFormDropList.dart';
import 'dynamic form/IFormTextField.dart';
import 'dynamic form/formable.dart';

class FormBuilder {


  List<IForm> jsonSeilize(){
    List<IForm> itemsToDraw = [];
    var data = jsonDecode(rawJson);
    for(var formElement in data ){
      var type  = _htmlFormToFlutters(formElement['type']);
      type!.setParameters(formElement);
      itemsToDraw.add(type);
    }

    return itemsToDraw;
  }




  IForm ? _htmlFormToFlutters(String type){
    switch (type){
      case 'select':
        return IFormDropList();
      case 'text':
        return IFormTextField();

      default :  return null;
    }


}}