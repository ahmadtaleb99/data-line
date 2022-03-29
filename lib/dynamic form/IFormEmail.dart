import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawEmailTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/formable.dart';

class IFormEmail implements IFormModel {
  dynamic _parameters;

  @override
  FormElement formElementFromJson({parameters}) {
    return DrawEmailTextField(
        label: _parameters['label'], required: _parameters['required'],
      showIfIsRequired: _parameters['showIfIsRequired'],
      showIfFieldValue: _parameters['showIfFieldValue'],
      isHidden: _parameters['isHidden'],
      isReadOnly: _parameters['isReadOnly'],
      showIfValueSelected: _parameters['showIfLogicCheckbox'], name: _parameters['name'],
      visible:  _parameters['showIfLogicCheckbox'] == true  ? false : true, deactivate: _parameters['deactivate'],

    );

  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;
  }

  @override
  Map<String, dynamic> fomrElementtoJson(FormElement formElement) {
    var emailFormElement = formElement as DrawEmailTextField;
    return {
        'type'  : 'email',
          'name' : emailFormElement.name,
        'label' : emailFormElement.label,
      'deactivate' : emailFormElement.deactivate,
      'required' : emailFormElement.required,
      'isHidden' : emailFormElement.isHidden,
      'isReadOnly' : emailFormElement.isReadOnly,
      'showIfLogicCheckBox' : emailFormElement.showIfValueSelected,
      'showIfIsRequired' : emailFormElement.showIfIsRequired,


    };
  }
}
