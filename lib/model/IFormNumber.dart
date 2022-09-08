 import 'package:flutter/src/widgets/framework.dart';
import 'package:datalines/Widgets/email_field_widget.dart';
import 'package:datalines/Widgets/number_field_widget.dart';
// ignore: unused_import
import 'package:datalines/Widgets/text_field_widget.dart';
import 'package:datalines/Widgets/form_element_widget.dart';
import 'package:datalines/model/IFormModel.dart';
import 'package:hive/hive.dart';

import '../utils/expression/Expression.dart';

part 'IFormNumber.g.dart';

@HiveType(typeId: 48)
class IFormNumber extends IFormModel {
  dynamic _parameters;

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

  @HiveField(11)
  Expression expression;

  @HiveField(12)
  dynamic value;

  IFormNumber({
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
    required this.expression,
    this.value
  }) : super( name: name,label: label) ;

  factory IFormNumber.fromJson(json) {
    return IFormNumber(
      label: json['label'],
      required: json['required'],
      showIfIsRequired: json['showIfIsRequired'],
      showIfFieldValue: json['showIfFieldValue'],
      isHidden: json['isHidden'],
      isReadOnly: json['isReadOnly'],
      showIfValueSelected: json['showIfLogicCheckbox'],
      name: json['name'],
      visible: json['showIfLogicCheckbox'] == true ? false : true,
      deactivate: json['deactivate'], expression: Expression(
        operator: OperatorsValues.map![json['operator']]!,
        value: json['expressionsValue'],

        value2: json['expressionsValue2'] ?? null));
  }
  @override
  FormElementWidget toWidget({parameters}) {
    print(_parameters);
    return NumberFieldWidget(
      label:  this.label,
      required: this.required,
      showIfIsRequired:  this.showIfIsRequired,
      showIfFieldValue:  this.showIfFieldValue,
      visible:   this.visible,

      showIfValueSelected:  this.showIfValueSelected,
      name:  this.name,
      value: this.value,

      expression:  this.expression,
    );
  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;
  }

  @override
  Map<String, dynamic> fomrElementtoJson(FormElementWidget formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
  }

  IFormNumber copyWith({
    String? label,
    String? name,
    bool? deactivate,
    bool? isHidden,
    bool? required,
    bool? isReadOnly,
    bool? visible,
    bool? showIfValueSelected,
    String? showIfFieldValue,
    bool? showIfIsRequired,
    Expression? expression,
    dynamic? value,
  }) {
    return IFormNumber(
      label: label ?? this.label,
      name: name ?? this.name,
      deactivate: deactivate ?? this.deactivate,
      isHidden: isHidden ?? this.isHidden,
      required: required ?? this.required,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      visible: visible ?? this.visible,
      showIfValueSelected: showIfValueSelected ?? this.showIfValueSelected,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      expression: expression ?? this.expression,
      value: value ?? this.value,
    );
  }

  @override
  String valueToString() {
    return value.toString();
  }

  @override
  bool isValid() {
    // TODO: implement isValid
    throw UnimplementedError();
  }


}
