import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawMultiSelect.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/FormModel.dart';
  import 'package:form_builder_test/dynamic%20form/IFormCheckBoxGroup.dart';
  import 'package:form_builder_test/dynamic%20form/IFormDrawRadioGroup.dart';
  import 'package:form_builder_test/dynamic%20form/IFormDropList.dart';
  import 'package:form_builder_test/dynamic%20form/IFormEmail.dart';
  import 'package:form_builder_test/dynamic%20form/IFormFilePicker.dart';
  import 'package:form_builder_test/dynamic%20form/IFormNumber.dart';
  import 'package:form_builder_test/dynamic%20form/IFormTextArea.dart';
  import 'package:form_builder_test/dynamic%20form/IFormTextField.dart';
  import 'package:form_builder_test/dynamic%20form/IFormModel.dart';

import '../dynamic form/matrix/matrix.dart';

abstract class FormApi {

  Future<List<FormModel>> getFormElements( );

  void saveFormElements();


  IFormModel ? htmlFormToFlutters(String type,dynamic json){
    switch (type){
      case 'select':
        return IFormDropList.fromJson(json);


      case 'text':
        return IFormTextField.fromJson(json);

      case 'textarea':
        return IFormTextArea.fromJson(json);
      case 'number':
        return IFormNumber.fromJson(json);

      case 'email':
        return IFormEmail.fromJson(json);

      case 'radio-group':
        return IFormDrawRadioGroup.fromJson(json);

      case 'file':
        return IFormFilePicker.fromJson(json);
        
        
       case 'matrix':
        return Matrix.fromJson(json);

      case 'checkbox-group':
        return IFormCheckBoxGroup.fromJson(json);
      default :  return null;
    }


  }


}