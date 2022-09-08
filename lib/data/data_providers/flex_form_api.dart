import 'dart:convert';

import 'package:datalines/data/form_api_abstract.dart';
import 'package:datalines/Widgets/form_element_widget.dart';
import 'package:datalines/model/FormModel.dart';
import 'package:datalines/model/IFormModel.dart';

import '../../utils/constants.dart';

class FlexFormApi extends FormApi{


  @override
  Future<List<OldFormModel>> getFormElements() async {
    List<OldFormModel> forms = [];
    await Future.delayed(Duration(seconds: 2  ));

    var data ;

    data = jsonDecode(formsJson);
    for(var form in data ){
      forms.add(OldFormModel.fromJson(form));
    }

    return forms;
  }

  @override
  void saveFormElements() {


  }








}