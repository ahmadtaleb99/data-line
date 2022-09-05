import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/Widgets/form_widget.dart';
import 'package:form_builder_test/Widgets/form_element_widget.dart';
import 'package:form_builder_test/model/IFormModel.dart';
import 'package:form_builder_test/model/IFormCheckBoxGroup.dart';
import 'package:form_builder_test/model/IFormDrawRadioGroup.dart';
import 'package:form_builder_test/model/IFormDropList.dart';
import 'package:form_builder_test/model/IFormEmail.dart';
import 'package:form_builder_test/model/IFormFilePicker.dart';
import 'package:form_builder_test/model/IFormNumber.dart';
import 'package:form_builder_test/model/IFormTextArea.dart';
import 'package:form_builder_test/model/IFormTextField.dart';
import 'package:form_builder_test/model/IFormModel.dart';
import 'package:hive/hive.dart';

import 'StarRating.dart';

part 'FormModel.g.dart';


@HiveType(typeId: 35)
class OldFormModel extends HiveObject implements IFormModel {

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




      default:
        return null;
    }
  }
  late String label;

  @HiveField(1)
  String name;

  @HiveField(2)
  String directionality;

  @HiveField(3)
  List<IFormModel> fields;

  @HiveField(4)
  dynamic value;

  OldFormModel({
    this.value,
    required this.name,
    required this.directionality,
    required this.fields,
  });
  factory OldFormModel.fromJson(json) {
    return OldFormModel(
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

  OldFormModel copyWith({
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
    return OldFormModel(
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

  @override
  bool isValid() {
    // TODO: implement isValid
    throw UnimplementedError();
  }
}
