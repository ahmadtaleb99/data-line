import 'package:datalines/Widgets/child_dropdown_widget.dart';
import 'package:datalines/Widgets/multi_select_widget.dart';
import 'package:datalines/Widgets/form_element_widget.dart';
import 'package:datalines/model/FormModel.dart';
  import 'package:datalines/model/IFormCheckBoxGroup.dart';
  import 'package:datalines/model/IFormDrawRadioGroup.dart';
  import 'package:datalines/model/IFormDropList.dart';
  import 'package:datalines/model/IFormEmail.dart';
  import 'package:datalines/model/IFormFilePicker.dart';
  import 'package:datalines/model/IFormNumber.dart';
  import 'package:datalines/model/IFormTextArea.dart';
  import 'package:datalines/model/IFormTextField.dart';
  import 'package:datalines/model/IFormModel.dart';


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

      case 'checkbox-group':
        return IFormCheckBoxGroup.fromJson(json);
      default :  return null;
    }


  }


}