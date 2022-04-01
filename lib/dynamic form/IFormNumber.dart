import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawEmailTextField.dart';
import 'package:form_builder_test/Widgets/DrawNumberField.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

import '../Expression.dart';

part 'IFormNumber.g.dart';

@HiveType(typeId: 28)
class IFormNumber implements IFormModel {
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
  }) ;

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
  FormElement toWidget({parameters}) {
    print(_parameters);
    return DrawNumberField(
      label:  this.label,
      required: this.required,
      showIfIsRequired:  this.showIfIsRequired,
      showIfFieldValue:  this.showIfFieldValue,
      visible:   this.visible,

      showIfValueSelected:  this.showIfValueSelected,
      name:  this.name,
      expression:  this.expression,
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
