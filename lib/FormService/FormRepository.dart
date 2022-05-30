import 'dart:convert';
import 'dart:io';

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

  FormApi _flexApi = FlexFormApi();
  LocalStorageApi _localApi = LocalStorageApi();

  List<FormWidget> _forms = [];
  List<FormModel> _formsModel = [];
  List<FormModel> _submittedForms = [];

  List<FormWidget> get forms => _forms;
  List<FormModel> get formsModel => _formsModel;
  List<FormModel> get availableForms => _availableForms;
  List<FormModel> get submittedForms => _submittedForms;

  List<FormModel> _availableForms = [];

  Future<void> initLocal() async {
    await _localApi.init();
    }


  FormRepository(){
    initLocal();
  }

  void addSubmittedForm(FormModel formModel){
    _localApi.addSubmittedForm(formModel);
  }

  void updateSubmission(FormModel submittedForm){
    _localApi.updateSubmittedForm(submittedForm);
  }


      int getLastSubmissionID (){
          return _localApi.getLastSubmissionID();
      }

  int getSubmissionID (FormModel formModel){
    return _localApi.getSubmissionID(formModel);
  }
  Future<List<FormModel>> getAvailableFormsFromLocal() async {
    return await  _localApi.getAvailableForms();
  }

  Future<List<FormModel>> LoadFormsModel()  async {
      _availableForms = await _flexApi.getFormElements();
      _localApi.addAvailableForms(availableForms);
    return _availableForms;
  }


  List<FormModel> getAllSubmissionByName(String formName){
    _submittedForms = _localApi.getAllSubmissionByName(formName);
     return _submittedForms;
  }




      void deleteForm(FormModel form){
          _submittedForms.remove(form);
          _localApi.deleteForm(form);
      }








  DrawCheckboxGroup getCheckBoxGroup (String name) {

    return _forms.firstWhere((element) => (element is DrawCheckboxGroup) && element.name == name) as DrawCheckboxGroup;
  }

  DrawRadioGroup getRadioGroup (String name) {

    return _forms.firstWhere((element) => (element is DrawRadioGroup) && element.name == name) as DrawRadioGroup;
  }


  List<FormElementWidget> getChildrenSelectsFor (String name) {

    return _forms.where((dynamic element) =>(  (element is DrawChildList)  ||  (element is DrawMultiSelect ) ) &&  (  element.parentName == name)).toList().cast()  ;
  }









}