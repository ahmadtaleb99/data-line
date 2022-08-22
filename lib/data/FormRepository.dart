import 'dart:convert' as form_repository;
import 'dart:io';

import 'package:form_builder_test/data/data_providers/flex_form_api.dart';
import 'package:form_builder_test/data/form_api_abstract.dart';
import 'package:form_builder_test/data/data_providers/local_storage_api.dart';
import 'package:form_builder_test/Widgets/child_dropdown_widget.dart';
import 'package:form_builder_test/Widgets/form_widget.dart';
import 'package:form_builder_test/Widgets/multi_select_widget.dart';
import 'package:form_builder_test/Widgets/form_element_widget.dart';
import 'package:form_builder_test/model/FormModel.dart';
import 'package:form_builder_test/model/IFormCheckBoxGroup.dart';
import 'package:form_builder_test/model/IFormDrawRadioGroup.dart';
import 'package:form_builder_test/model/IFormFilePicker.dart';
import 'package:form_builder_test/model/IFormNumber.dart';
import 'package:form_builder_test/model/IFormTextArea.dart';

import '../Widgets/checkbox_group_widget.dart';
import '../Widgets/radio_group_widget.dart';
import '../utils/constants.dart';
import '../model/IFormDropList.dart';
import '../model/IFormEmail.dart';
import '../model/IFormTextField.dart';
import '../model/IFormModel.dart';

class OldFormRepository {

  FormApi _flexApi = FlexFormApi();
  LocalStorageApi _localApi = LocalStorageApi();

  List<FormWidget> _forms = [];
  List<OldFormModel> _formsModel = [];
  List<OldFormModel> _submittedForms = [];

  List<FormWidget> get forms => _forms;
  List<OldFormModel> get formsModel => _formsModel;
  List<OldFormModel> get availableForms => _availableForms;
  List<OldFormModel> get submittedForms => _submittedForms;

  List<OldFormModel> _availableForms = [];

  Future<void> initLocal() async {
    await _localApi.init();
    }


  OldFormRepository(){
    initLocal();
  }

  void addSubmittedForm(OldFormModel formModel){
    _localApi.addSubmittedForm(formModel);
  }

  void updateSubmission(OldFormModel submittedForm){
    _localApi.updateSubmittedForm(submittedForm);
  }


      int getLastSubmissionID (){
          return _localApi.getLastSubmissionID();
      }

  int getSubmissionID (OldFormModel formModel){
    return _localApi.getSubmissionID(formModel);
  }
  Future<List<OldFormModel>> getAvailableFormsFromLocal() async {
    return await  _localApi.getAvailableForms();
  }

  Future<List<OldFormModel>> LoadFormsModel()  async {
      _availableForms = await _flexApi.getFormElements();
      _localApi.addAvailableForms(availableForms);
    return _availableForms;
  }


  List<OldFormModel> getAllSubmissionByName(String formName){
    _submittedForms = _localApi.getAllSubmissionByName(formName);
     return _submittedForms;
  }




      void deleteForm(OldFormModel form){
          _submittedForms.remove(form);
          _localApi.deleteForm(form);
      }








  CheckboxGroupWidgetOld getCheckBoxGroup (String name) {

    return _forms.firstWhere((element) => (element is CheckboxGroupWidgetOld) && element.name == name) as CheckboxGroupWidgetOld;
  }

  RadioGroupWidget getRadioGroup (String name) {

    return _forms.firstWhere((element) => (element is RadioGroupWidget) && element.name == name) as RadioGroupWidget;
  }


  List<FormElementWidget> getChildrenSelectsFor (String name) {

    return _forms.where((dynamic element) =>(  (element is ChildDropDownWidget)  ||  (element is MultiSelectWidget ) ) &&  (  element.parentName == name)).toList().cast()  ;
  }









}