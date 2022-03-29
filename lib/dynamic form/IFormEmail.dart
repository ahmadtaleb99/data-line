import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawEmailTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/formable.dart';

class IFormEmail implements IFormModel {
  String label;
  String name;
  bool deactivate;
  bool isHidden;
  bool required;
  bool isReadOnly;
  bool? visible;
  bool showIfValueSelected;
  String? showIfFieldValue;
  bool? showIfIsRequired;

  IFormEmail({
    required this.label,
    required this.name,
    required this.deactivate,
    required this.isHidden,
    required this.required,
    required this.isReadOnly,
    this.visible,
    required this.showIfValueSelected,
    this.showIfFieldValue,
    this.showIfIsRequired,
  });





  factory IFormEmail.FromJson({parameters}) {
    return IFormEmail(
      label: parameters['label'],
      required: parameters['required'],
      showIfIsRequired: parameters['showIfIsRequired'],
      showIfFieldValue: parameters['showIfFieldValue'],
      isHidden: parameters['isHidden'],
      isReadOnly: parameters['isReadOnly'],
      showIfValueSelected: parameters['showIfLogicCheckbox'],
      name: parameters['name'],
      visible: parameters['showIfLogicCheckbox'] == true ? false : true,
      deactivate: parameters['deactivate'],
    );
  }

  @override
  FormElement formElementFromJson({parameters}) {
    return DrawEmailTextField(
      label: this.label,
      required: this.required,
      showIfIsRequired: this.showIfIsRequired,
      showIfFieldValue: this.showIfFieldValue,
      isHidden: this.isHidden,
      isReadOnly: this.isReadOnly,
      showIfValueSelected: this.showIfValueSelected,
      name: this.name,
      visible: this.visible == true ? false : true,
      deactivate: this.deactivate,
    );
  }


  @override
  Map<String, dynamic> fomrElementtoJson(FormElement formElement) {
    var emailFormElement = formElement as DrawEmailTextField;
    return {
      'type': 'email',
      'name': emailFormElement.name,
      'label': emailFormElement.label,
      'deactivate': emailFormElement.deactivate,
      'required': emailFormElement.required,
      'isHidden': emailFormElement.isHidden,
      'isReadOnly': emailFormElement.isReadOnly,
      'showIfLogicCheckBox': emailFormElement.showIfValueSelected,
      'showIfIsRequired': emailFormElement.showIfIsRequired,
    };
  }






}
