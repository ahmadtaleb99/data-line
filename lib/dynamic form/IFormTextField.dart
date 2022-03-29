import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';

class IFormTextField implements IFormModel {
  dynamic _parameters;

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
  IFormTextField({
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

  factory IFormTextField.fromJson(json) {
    return IFormTextField(
      label: json['label'],
      required: json['required'],
      showIfIsRequired: json['showIfIsRequired'],
      showIfFieldValue: json['showIfFieldValue'],
      isHidden: json['isHidden'],
      isReadOnly: json['isReadOnly'],
      showIfValueSelected: json['showIfLogicCheckbox'],
      name: json['name'],
      visible: json['showIfLogicCheckbox'] == true ? false : true,
      deactivate: json['deactivate'], );
  }

  @override
  FormElement getFormElement({parameters}) {
    return DrawTextField(
      label: this.label,
      required: this.required,
      showIfValueSelected: this.showIfValueSelected,
      showIfFieldValue: this.showIfFieldValue,
      showIfIsRequired: this.showIfIsRequired,
      visible: this.visible,
      name: this.name,
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
