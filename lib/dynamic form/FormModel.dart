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

import 'StarRating.dart';
import 'matrix/matrix.dart';

part 'FormModel.g.dart';


@HiveType(typeId: 35)
class FormModel extends HiveObject implements IFormModel {

  static IFormModel? _getFieldFromType(String type, dynamic json) {
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

        case 'starrating':
        return StarRating.fromJson(json);

         case 'matrix':
        return Matrix.fromJson(json);


      default:
        return null;
    }
  }

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
            .map((field) => _getFieldFromType(field['type'], field)!)
            .toList()));
  }


  @override
  FormElementWidget toWidget() {
    List<FormElementWidget> fieldsList = [];
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
    List<FormElementWidget>? fieldsList,
  }) {

    List<IFormModel> list = [];
    for(var item in this.fields){
      list.add(item.copyWith());
    }
    return FormModel(
      name: name ?? this.name,
      directionality: directionality ?? this.directionality,
      fields: list ,
      value: value ?? this.value,
    );
  }

  @override
  String valueToString() {
    return this.value.toString();
  }
}
