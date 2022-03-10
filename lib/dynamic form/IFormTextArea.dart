import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawTextArea.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/dynamic%20form/formable.dart';

class IFormTextArea implements IForm{
  dynamic _parameters;






  @override
  Widget drawFormElement({parameters}) {
    return DrawTextArea(minLength: _parameters['minlength'], maxLength: _parameters['maxlength'], label: _parameters['label']);
  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;

  }

}