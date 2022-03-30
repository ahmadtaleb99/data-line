import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawEmailTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

part 'IFormEmail.g.dart';
@HiveType(typeId: 25)
class IFormEmail extends IFormModel {

  @HiveField(1)
  String label;

  @HiveField(2)
  String name;

  @HiveField(3)
  bool deactivate;
  @HiveField(4)
  bool isHidden;
  @HiveField(5)
  bool required;
  @HiveField(6)
  bool isReadOnly;
  @HiveField(7)
  bool? visible;
  @HiveField(8)
  bool showIfValueSelected;
  @HiveField(9)
  String? showIfFieldValue;
  @HiveField(10)
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





  factory IFormEmail.fromJson(parameters) {
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
  FormElement getFormElement({parameters}) {
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
