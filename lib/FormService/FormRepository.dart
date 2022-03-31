import 'dart:convert';

import 'package:form_builder_test/FormService/FlexFormApi.dart';
import 'package:form_builder_test/FormService/FormApi.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawForm.dart';
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

  List<DrawForm> _forms = [];

  List<DrawForm> get forms => _forms;





  Future<List<DrawForm>> LoadForms(int formId)  async {
    this._forms = [];
    for(var element in await _apiClient.getFormElements()){
      this._forms.add(element.getFormElement() as DrawForm) ;
    }

    return _forms;
  }

  DrawCheckboxGroup getCheckBoxGroup (String name) {

    return _forms.firstWhere((element) => (element is DrawCheckboxGroup) && element.name == name) as DrawCheckboxGroup;
  }

  DrawRadioGroup getRadioGroup (String name) {

    return _forms.firstWhere((element) => (element is DrawRadioGroup) && element.name == name) as DrawRadioGroup;
  }


  List<FormElement> getChildrenSelectsFor (String name) {

    return _forms.where((dynamic element) =>(  (element is DrawChildList)  ||  (element is DrawMultiSelect ) ) &&  (  element.parentName == name)).toList().cast()  ;
  }




}