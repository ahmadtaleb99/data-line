import 'dart:convert';

import 'package:form_builder_test/FormService/FormApi.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/FormModel.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';

import '../constants.dart';

class FlexFormApi extends FormApi{


  @override
  List<IFormModel> getFormElements(int formID ) {
    List<IFormModel> formElements = [];

    var data ;
      data = jsonDecode(formsJson);
    for(var formElement in data ){
      // var type  = htmlFormToFlutters(formElement['type'],formElement);
      formElements.add(FormModel.fromJson(formElement));
    }

    return formElements;
  }

  @override
  void saveFormElements() {
    // TODO: implement saveFormElements
  }








}