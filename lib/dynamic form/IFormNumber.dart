import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawEmailTextField.dart';
import 'package:form_builder_test/Widgets/DrawNumberField.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/formable.dart';

import '../Expression.dart';

class IFormNumber implements IFormModel {
  dynamic _parameters;

  @override
  FormElement formElementFromJson({parameters}) {
    print(_parameters);
    return DrawNumberField(
      label: _parameters['label'],
      required: _parameters['required'],
      showIfIsRequired: _parameters['showIfIsRequired'],
      showIfFieldValue: _parameters['showIfFieldValue'],
      visible:  _parameters['showIfLogicCheckbox'] == true  ? false : true,

      showIfValueSelected: _parameters['showIfLogicCheckbox'], name: _parameters['name'],
      expression: Expression(
          operator: OperatorsValues.map![_parameters['operator']]!,
          value: _parameters['expressionsValue'],

          value2: _parameters['expressionsValue2'] ?? null),
    );
  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;
  }

  @override
  Map<String, dynamic> fomrElementtoJson(FormElement formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
  }
}
