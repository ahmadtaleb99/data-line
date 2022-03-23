import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/formable.dart';

class IFormTextField implements IForm{
  dynamic _parameters;






  @override
  IDrawable drawFormElement({parameters}) {
    print(_parameters['showIfLogicCheckbox']);
    return DrawTextField(label: _parameters['label'], required: _parameters['required'],
      showIfValueSelected: _parameters['showIfLogicCheckbox'],
      showIfFieldValue: _parameters['showIfFieldValue'] ?? null ,
      showIfIsRequired: _parameters['showIfLogicCheckbox'] ?? null,

        visible:  _parameters['showIfLogicCheckbox'] == true  ? false : true,
      name: _parameters['name'],  );
  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;

  }
  
}