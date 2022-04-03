import 'dart:convert';

import 'package:form_builder_test/FormService/FlexFormApi.dart';
import 'package:form_builder_test/FormService/FormApi.dart';
import 'package:form_builder_test/FormService/LocalStorageApi.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawForm.dart';
import 'package:form_builder_test/Widgets/DrawMultiSelect.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/FormModel.dart';
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
  LocalStorageApi _localApi = LocalStorageApi();

  List<FormWidget> _forms = [];
  List<FormModel> _formsModel = [];

  List<FormWidget> get forms => _forms;
  List<FormModel> get formsModel => _formsModel;


  Future<void> initLocal() async {
    await _localApi.init();
    }


  Future<List<FormWidget>> LoadForms(int formId)  async {
    this._forms = [];
    for(var element in await _apiClient.getFormElements()){
      this._forms.add(element.toWidget() as FormWidget) ;
    }

    return _forms;
  }


  Future<List<FormModel>> LoadFormsModel()  async {
    this._formsModel = [];
    for(var element in await _apiClient.getFormElements()){
      this._formsModel.add(element as FormModel) ;
    }

    return _formsModel;
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


  void savetoLocal(FormModel formModel){
    _localApi.saveForm(formModel);
  }


  List<FormModel>  getForms(){
    this._formsModel =   _localApi.getAllForms();
    return _formsModel;
  }


  Future<FormModel> getFormByName(String formName) async {
     var form = await   _localApi.getFormByName(formName);


     print (form.fields.toString());
     print (form.name + ' second');
     if(form != null)
     return form;

     throw NullThrownError();
  }


}