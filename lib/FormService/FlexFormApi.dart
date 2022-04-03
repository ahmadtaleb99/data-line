import 'dart:convert';

import 'package:form_builder_test/FormService/FormApi.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/FormModel.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';

import '../constants.dart';

class FlexFormApi extends FormApi{


  @override
  Future<List<IFormModel>> getFormElements() async {
    List<IFormModel> forms = [];
    await Future.delayed(Duration(seconds: 1));

    var data ;

    data = jsonDecode(formsJson);
    for(var form in data ){
      // var type  = htmlFormToFlutters(formElement['type'],formElement);
      forms.add(FormModel.fromJson(form));
    }

    return forms;
  }

  @override
  void saveFormElements() {


  }








}