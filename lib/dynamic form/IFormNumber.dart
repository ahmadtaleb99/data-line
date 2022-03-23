import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawEmailTextField.dart';
import 'package:form_builder_test/Widgets/DrawNumberField.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/formable.dart';

import '../Expression.dart';

class IFormNumber implements IForm{
  dynamic _parameters;






  @override
  IDrawable drawFormElement({parameters}) {
    print(_parameters);
    return DrawNumberField(label: _parameters['label'],
      required: _parameters['required'],
      expression: Expression(operator: OperatorsValues.map![_parameters['operator']]!, value: _parameters['expressionsValue'], value2: _parameters['expressionsValue2'] ?? null),);
  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;

  }


}