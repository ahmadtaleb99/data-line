import 'dart:convert';

import 'package:form_builder_test/FormService/FormApi.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';

import '../constants.dart';

class FlexFormApi extends FormApi{


  @override
  List<IFormModel> getFormElements(int formID ) {
    List<IFormModel> formElements = [];
    var data ;
    if(formID == 0)
      data = jsonDecode(rawJson);
    else if (formID == 1)
      data = jsonDecode(rawJson1);
    for(var formElement in data ){
      var type  = htmlFormToFlutters(formElement['type'],formElement);
      formElements.add(type!);

    }

    return formElements;
  }

  @override
  void saveFormElements() {
    // TODO: implement saveFormElements
  }








}