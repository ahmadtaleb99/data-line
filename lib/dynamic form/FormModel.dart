import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/Widgets/DrawForm.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:form_builder_test/dynamic%20form/IFormCheckBoxGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormDrawRadioGroup.dart';
import 'package:form_builder_test/dynamic%20form/IFormDropList.dart';
import 'package:form_builder_test/dynamic%20form/IFormEmail.dart';
import 'package:form_builder_test/dynamic%20form/IFormFilePicker.dart';
import 'package:form_builder_test/dynamic%20form/IFormNumber.dart';
import 'package:form_builder_test/dynamic%20form/IFormTextArea.dart';
import 'package:form_builder_test/dynamic%20form/IFormTextField.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

part 'FormModel.g.dart';

IFormModel? getType(String type, dynamic json) {
  switch (type) {
    case 'select':
      return IFormDropList.fromJson(json);

    case 'text':
      return IFormTextField.fromJson(json);

    case 'textarea':
      return IFormTextArea.fromJson(json);
    case 'number':
      return IFormNumber.fromJson(json);

    case 'email':
      return IFormEmail.fromJson(json);

    case 'radio-group':
      return IFormDrawRadioGroup.fromJson(json);

    case 'file':
      return IFormFilePicker.fromJson(json);

    case 'checkbox-group':
      return IFormCheckBoxGroup.fromJson(json);
    default:
      return null;
  }
}
@HiveType(typeId: 35)
class FormModel extends HiveObject implements IFormModel {
  @HiveField(1)
  String name;

  @HiveField(2)

  String directionality;

  @HiveField(3)

  List<IFormModel> fields;

  @HiveField(4)
  dynamic value;


  FormModel({
    this.value,

    required this.name,
    required this.directionality,
    required this.fields,
  });
  factory FormModel.fromJson(json) {
    return FormModel(
        name: json['name'],
        directionality: json['directionality'],
        fields: List.from(json['fields']
            .map((field) => getType(field['type'], field)!)
            .toList()));
  }

  @override
  Map<String, dynamic> fomrElementtoJson(FormElement formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
  }

  @override
  FormElement toWidget() {
    List<FormElement> fieldsList = [];
    for (var field in fields) {
      fieldsList.add(field.toWidget());
    }

    return FormWidget(label: name, name: name, fields: fieldsList);
  }

  FormModel copyWith({
    String? name,
    String? directionality,
    List<IFormModel>? fields,
    dynamic? value,
    List<FormElement>? fieldsList,
  }) {
    return FormModel(
      name: name ?? this.name,
      directionality: directionality ?? this.directionality,
      fields: this.fields.map((e) => e),
      value: value ?? this.value,
    );
  }
}
