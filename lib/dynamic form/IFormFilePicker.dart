import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawEmailTextField.dart';
import 'package:form_builder_test/Widgets/DrawFilePicker.dart';
import 'package:form_builder_test/Widgets/DrawNumberField.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';

import '../Expression.dart';

class IFormFilePicker implements IFormModel {
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
  final int maxFileSize;
  FileTypeEnum fileType;

  IFormFilePicker( {
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

    required this.maxFileSize,
    required this.fileType,
  });

  factory IFormFilePicker.fromJson(json) {
    return IFormFilePicker(
      label: json['label'],
      required: json['required'],
      showIfIsRequired: json['showIfIsRequired'],
      showIfFieldValue: json['showIfFieldValue'],
      isHidden: json['isHidden'],
      isReadOnly: json['isReadOnly'],
      showIfValueSelected: json['showIfLogicCheckbox'],
      name: json['name'],
      maxFileSize: json['maxFileSize'],
        visible: json['showIfLogicCheckbox'] == true ? false : true,
      deactivate: json['deactivate'],
      fileType: fileTypeEnumValues.map![json['fileType']]!,
    );
  }
  
  @override
  FormElement getFormElement({parameters}) {
    return DrawFilePicker(
      label: this.label,
      required: this.required,
      showIfIsRequired: this.showIfIsRequired,
      showIfFieldValue: this.showIfFieldValue,
      isHidden: this.isHidden,
      isReadOnly: this.isReadOnly,
      showIfValueSelected: this.showIfValueSelected,
      name: this.name,
      visible: this.visible,
      deactivate: this.deactivate,
      maxFileSize: this.maxFileSize,
      fileType: this.fileType,
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
