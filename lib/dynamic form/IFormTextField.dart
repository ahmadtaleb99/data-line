import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

part 'IFormTextField.g.dart';


@HiveType(typeId: 50)
class IFormTextField implements IFormModel {
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
  dynamic value;



  IFormTextField({
    required this.label,
    required this.name,
    required this.deactivate,
    required this.isHidden,
    required this.required,
    required this.isReadOnly,
    this.visible,
    this.value,
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
      deactivate: json['deactivate'], );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IFormTextField &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          name == other.name &&
          deactivate == other.deactivate &&
          isHidden == other.isHidden &&
          required == other.required &&
          isReadOnly == other.isReadOnly &&
          visible == other.visible &&
          showIfValueSelected == other.showIfValueSelected &&
          showIfFieldValue == other.showIfFieldValue &&
          showIfIsRequired == other.showIfIsRequired &&
          value == other.value;

  @override
  int get hashCode =>
      label.hashCode ^
      name.hashCode ^
      deactivate.hashCode ^
      isHidden.hashCode ^
      required.hashCode ^
      isReadOnly.hashCode ^
      visible.hashCode ^
      showIfValueSelected.hashCode ^
      showIfFieldValue.hashCode ^
      showIfIsRequired.hashCode ^
      value.hashCode;

  @override
  FormElement toWidget({parameters}) {
    return DrawTextField(

      label: this.label,
      value: this.value,
      required: this.required,
      showIfValueSelected: this.showIfValueSelected,
      showIfFieldValue: this.showIfFieldValue,
      showIfIsRequired: this.showIfIsRequired,
      name: this.name,
      visible: this.showIfValueSelected == true && value == null ? false : true,
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

  IFormTextField copyWith({
    dynamic? parameters,
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
    dynamic? value,
  }) {
    return IFormTextField(
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
      value: value ?? this.value,
    );
  }

  @override
  String valueToString() {
    return this.value.toString();
  }
}
