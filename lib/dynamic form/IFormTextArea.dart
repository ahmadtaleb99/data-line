import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawTextArea.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';

class IFormTextArea implements IFormModel {
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

  int minLength;
  int maxLength;

  IFormTextArea({
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
    required this.minLength,
    required this.maxLength,});

  factory IFormTextArea.fromJson(json) {
    return IFormTextArea(
        label: json['label'],
        required: json['required'],
      minLength: json['minlength'],
      maxLength: json['maxlength'],
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
    return DrawTextArea(
      minLength: this.minLength,
      maxLength: this.maxLength,
      label: this.label,
      required: this.required,
      showIfIsRequired: this.showIfIsRequired,
      showIfFieldValue: this.showIfFieldValue,
      visible:  this.visible,
      showIfValueSelected: this.showIfValueSelected,
      name: this.name,  );
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
