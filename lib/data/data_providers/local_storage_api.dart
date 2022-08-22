import 'package:form_builder_test/data/form_api_abstract.dart' as form_repository;
import 'package:form_builder_test/model/CheckboxItem.dart';
import 'package:form_builder_test/model/DropDownItem.dart';
import 'package:form_builder_test/model/FileTypeEnum.dart';
import 'package:form_builder_test/model/FormModel.dart';
import 'package:form_builder_test/model/IFormCheckBoxGroup.dart';
import 'package:form_builder_test/model/IFormDrawRadioGroup.dart';
import 'package:form_builder_test/model/IFormDropList.dart';
import 'package:form_builder_test/model/IFormEmail.dart';
import 'package:form_builder_test/model/IFormFilePicker.dart';
import 'package:form_builder_test/model/IFormModel.dart';
import 'package:form_builder_test/model/IFormNumber.dart';
import 'package:form_builder_test/model/IFormTextArea.dart';
import 'package:form_builder_test/model/IFormTextField.dart';
import 'package:form_builder_test/model/RadioItem.dart';
import 'package:form_builder_test/model/StarRating.dart';
import 'package:form_builder_test/model/matrix/fields/matrix_record.dart';
import 'package:form_builder_test/model/matrix/matrix.dart';
import 'package:hive/hive.dart';

import '../../model/matrix/fields/MatrixDropDown.dart';
import '../../utils/expression/Expression.dart';

class LocalStorageApi  extends form_repository.FormApi{

    late  Box <OldFormModel>   _formBox;
    late  Box<List<OldFormModel>>   _availableBox;

    Box<List<OldFormModel>> get listBox => _availableBox;

  set listBox(Box<List<OldFormModel>> value) {
    _availableBox = value;
  }

  LocalStorageApi() {


    }

  Future<void> init() async {
    // Hive.registerAdapter(FormModelAdapter());
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
    // Hive.registerAdapter(OperatorAdapter());
    Hive.registerAdapter(StarRatingAdapter());

    Hive.registerAdapter(MatrixAdapter());
    Hive.registerAdapter(MatrixDropDownAdapter());
    Hive.registerAdapter(MatrixCheckboxAdapter());
    Hive.registerAdapter(MatrixDatePickerAdapter());
    Hive.registerAdapter(MatrixCheckboxGroupAdapter());
    Hive.registerAdapter(MatrixRadioGroupAdapter());
    Hive.registerAdapter(MatrixNumberAdapter());
    Hive.registerAdapter(MatrixTextFieldAdapter());
    Hive.registerAdapter(MatrixRecordModelAdapter());



  }


  @override
  Future<List<OldFormModel>> getFormElements() {

    throw UnimplementedError();
  }

  @override
  void saveFormElements() {  }



    Future<List<OldFormModel>> getAvailableForms() async {
      var list = await  _availableBox.get('available') as List<OldFormModel> ;
      return list ;
    }

  Future<void> addAvailableForms(List<OldFormModel> availableForms) async {
   await  _availableBox.put('available', availableForms) ;
  }



      int getLastSubmissionID(){
    if(_formBox.keys.isNotEmpty)
    return _formBox.keys.last ;
    else return  -1;
      }

      int getSubmissionID(OldFormModel formModel){
        final form = _formBox.values.firstWhere((element) => element == formModel);
        final index = form.key as int ;
    return index;
      }


       void updateSubmittedForm(OldFormModel submittedForm) {
         final form = _formBox.values.firstWhere((element) => element == submittedForm);
         final index = form.key as int ;
          _formBox.put(index,submittedForm);
    }



    Future<void> addSubmittedForm(OldFormModel submittedForm) async {

      await  _formBox.add( submittedForm) ;
    }



    List<OldFormModel> getAllSubmissionByName(String formName) {
    print(_formBox.keys.toString());
    return _formBox.values.where((element) => element.name == formName).toList();
  }


  // FormModel getFormByName(String formName) {
  //   return _formBox.get(formName,defaultValue: null)!;
  // }
      void deleteForm(OldFormModel form) {
              print(_formBox.keys.toList().toString());

          final formToDelete = _formBox.values.firstWhere((element) => element == form);
          final index = formToDelete.key as int ;
            _formBox.delete(index);
    }}

