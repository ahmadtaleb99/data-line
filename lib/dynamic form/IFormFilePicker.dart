import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawEmailTextField.dart';
import 'package:form_builder_test/Widgets/DrawFilePicker.dart';
import 'package:form_builder_test/Widgets/DrawNumberField.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/formable.dart';

import '../Expression.dart';

class IFormFilePicker implements IFormModel {
  dynamic _parameters;

  @override
  FormElement formElementFromJson({parameters}) {
    return DrawFilePicker(
      label: _parameters['label'],
      required: _parameters['required'],
      showIfIsRequired: _parameters['showIfIsRequired'],
      showIfFieldValue: _parameters['showIfFieldValue'],
      showIfValueSelected: _parameters['showIfLogicCheckbox'],
      name: _parameters['name'],
      maxFileSize: _parameters['maxFileSize'],
      visible:  _parameters['showIfLogicCheckbox'] == true  ? false : true,
      fileType: fileTypeEnumValues.map![_parameters['fileType']]!,
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
