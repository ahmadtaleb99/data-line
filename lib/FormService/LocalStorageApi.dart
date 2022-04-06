import 'package:form_builder_test/Expression.dart';
import 'package:form_builder_test/FormService/FormApi.dart';
import 'package:form_builder_test/dynamic%20form/CheckboxItem.dart';
import 'package:form_builder_test/dynamic%20form/DropDownItem.dart';
import 'package:form_builder_test/dynamic%20form/FileTypeEnum.dart';
import 'package:form_builder_test/dynamic%20form/FormModel.dart';
import 'package:form_builder_test/dynamic%20form/IFormCheckBoxGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormDrawRadioGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormDropList.dart';
import 'package:form_builder_test/dynamic%20form/IFormEmail.dart';
import 'package:form_builder_test/dynamic%20form/IFormFilePicker.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:form_builder_test/dynamic%20form/IFormNumber.dart';
import 'package:form_builder_test/dynamic%20form/IFormTextArea.dart';
import 'package:form_builder_test/dynamic%20form/IFormTextField.dart';
import 'package:form_builder_test/dynamic%20form/RadioItem.dart';
import 'package:hive/hive.dart';

class LocalStorageApi  extends FormApi{

    late  Box <FormModel>   _formBox;
    late  Box<List<FormModel>>   _availableBox;

    Box<List<FormModel>> get listBox => _availableBox;

  set listBox(Box<List<FormModel>> value) {
    _availableBox = value;
  }

  LocalStorageApi() {


    }

  Future<void> init() async {
    Hive.registerAdapter(FormModelAdapter());
    Hive.registerAdapter(CheckboxItemAdapter());
    Hive.registerAdapter(DropDownItemAdapter());
    Hive.registerAdapter(IFormCheckBoxGroupAdapter());
    Hive.registerAdapter(IFormDrawRadioGroupAdapter());
    Hive.registerAdapter(IFormDropListAdapter());
    Hive.registerAdapter(IFormEmailAdapter());
    Hive.registerAdapter(IFormFilePickerAdapter());
    Hive.registerAdapter(IFormNumberAdapter());
    Hive.registerAdapter(IFormTextAreaAdapter());
    Hive.registerAdapter(IFormTextFieldAdapter());
    Hive.registerAdapter(RadioItemAdapter());
    Hive.registerAdapter(FileTypeEnumAdapter());
    Hive.registerAdapter(ExpressionAdapter());
    Hive.registerAdapter(OperatorAdapter());
   _formBox  = await Hive.openBox<FormModel>('form');
   _availableBox   = await Hive.openBox('available');


  }


  @override
  Future<List<FormModel>> getFormElements() {

    throw UnimplementedError();
  }

  @override
  void saveFormElements() {  }



    Future<List<FormModel>> getAvailableForms() async {
      var list = await  _availableBox.get('available') as List<FormModel> ;
      return list ;
    }

  Future<void> addAvailableForms(List<FormModel> availableForms) async {
   await  _availableBox.put('available', availableForms) ;
  }





    
       void updateSubmittedForm(FormModel submittedForm) {
         final form = _formBox.values.firstWhere((element) => element == submittedForm);
         final index = form.key as int ;
          _formBox.put(index,submittedForm);
    }



    Future<void> addSubmittedForm(FormModel submittedForm) async {

      await  _formBox.add( submittedForm) ;
    }



    List<FormModel> getAllSubmissionByName(String formName) {
    return _formBox.values.where((element) => element.name == formName).toList();
  }


  // FormModel getFormByName(String formName) {
  //   return _formBox.get(formName,defaultValue: null)!;
  // }






}