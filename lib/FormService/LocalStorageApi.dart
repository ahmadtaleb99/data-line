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

    late  Box<FormModel>   _formBox;

    LocalStorageApi() {
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
                init();

    }

  Future<void> init() async {
   _formBox  = await Hive.openBox<FormModel>('form');

  }


  @override
  Future<List<IFormModel>> getFormElements() {

    throw UnimplementedError();
  }

  @override
  void saveFormElements() {  }





    
  void saveForm(FormModel formModel) {
          _formBox.put(formModel.name, formModel);
  }



  List<FormModel> getAllForms() {
    return _formBox.values.toList();
  }


  FormModel getFormByName(String formName) {
    return _formBox.get(formName,defaultValue: null)!;
  }






}