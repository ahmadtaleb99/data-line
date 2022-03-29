import 'dart:convert';

import 'package:form_builder_test/FormService/FlexFormApi.dart';
import 'package:form_builder_test/FormService/FormApi.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawMultiSelect.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormCheckBoxGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormDrawRadioGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormFilePicker.dart';
import 'package:form_builder_test/dynamic%20form/IFormNumber.dart';
import 'package:form_builder_test/dynamic%20form/IFormTextArea.dart';

import '../Widgets/DrawChecboxGroup.dart';
import '../Widgets/DrawRadioGroup.dart';
import '../constants.dart';
import '../dynamic form/IFormDropList.dart';
import '../dynamic form/IFormEmail.dart';
import '../dynamic form/IFormTextField.dart';
import '../dynamic form/IFormModel.dart';

class FormRepository {

  FormApi _apiClient = FlexFormApi();

  List<FormElement> _formElementList = [];

  List<FormElement> get formElementList => _formElementList;





  Future<List<FormElement>> LoadFormElements(int formId) async {
    this._formElementList = [];
    await Future.delayed(Duration(seconds: 1));
    for(var element in _apiClient.getFormElements(formId)){
      print(element);
      this._formElementList.add(element.getFormElement()) ;
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




}