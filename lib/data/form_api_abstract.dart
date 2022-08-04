import 'package:form_builder_test/Widgets/child_dropdown_widget.dart';
import 'package:form_builder_test/Widgets/multi_select_widget.dart';
import 'package:form_builder_test/Widgets/form_element_widget.dart';
import 'package:form_builder_test/model/FormModel.dart';
  import 'package:form_builder_test/model/IFormCheckBoxGroup.dart';
  import 'package:form_builder_test/model/IFormDrawRadioGroup.dart';
  import 'package:form_builder_test/model/IFormDropList.dart';
  import 'package:form_builder_test/model/IFormEmail.dart';
  import 'package:form_builder_test/model/IFormFilePicker.dart';
  import 'package:form_builder_test/model/IFormNumber.dart';
  import 'package:form_builder_test/model/IFormTextArea.dart';
  import 'package:form_builder_test/model/IFormTextField.dart';
  import 'package:form_builder_test/model/IFormModel.dart';

import '../model/matrix/matrix.dart';

abstract class FormApi {

  Future<List<OldFormModel>> getFormElements( );

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