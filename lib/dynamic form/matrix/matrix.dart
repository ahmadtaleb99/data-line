import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/MatrixWidget.dart';
import 'package:form_builder_test/Widgets/StarRatingWidget.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/MatrixCheckboxGroup.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/MatrixDatePicker.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/MatrixDropDown.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/MatrixNumber.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/MatrixRadioGroup.dart';
import 'package:hive/hive.dart';

import 'fields/MatrixCheckbox.dart';
import 'fields/MatrixTextField.dart';
export 'fields/MatrixTextField.dart';
export 'fields/MatrixDropDown.dart';
export 'fields/MatrixCheckbox.dart';
export 'fields/MatrixCheckboxGroup.dart';
export 'fields/MatrixRadioGroup.dart';
export 'fields/MatrixNumber.dart';
export 'fields/MatrixDatePicker.dart';

part 'matrix.g.dart';


@HiveType(typeId: 54)
class Matrix implements IFormModel {

  static IFormModel? _getFieldFromType(String type, dynamic json) {
    switch (type) {
      case 'select':
        return MatrixDropDown.fromJson(json);

      case 'text':
        return MatrixTextField.fromJson(json);



      case 'number':
        return MatrixNumber.fromJson(json);


      case 'radio-group':
        return MatrixRadioGroup.fromJson(json);

      case 'date':
        return MatrixDatePicker.fromJson(json);


      case 'checkbox-group':
        return MatrixCheckboxGroup.fromJson(json);


     case 'checkbox':
        return MatrixCheckbox.fromJson(json);

      default:
        return null;
    }
  }



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

  @HiveField(12)
  List<IFormModel> values;

  @HiveField(13)
  int maxRecordsCount;

   List<List<IFormModel>> ? records = [];

  Matrix({
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
    required this.maxRecordsCount,
    required this.values

  });

  factory Matrix.fromJson(json) {
    return Matrix(
      label: json['label'],
      required: json['required'],
      showIfIsRequired: json['showIfIsRequired'],
      showIfFieldValue: json['showIfFieldValue'],
      isHidden: json['isHidden'],
      isReadOnly: json['isReadOnly'] ?? false,
      showIfValueSelected: json['showIfLogicCheckbox'],
      name: json['name'],
        visible: json['showIfLogicCheckbox'] == true ? false : true,
        maxRecordsCount: json['maxRecordsCount'],
      deactivate: json['deactivate'],
        values: List<IFormModel>.from(json['values'].map((e) => _getFieldFromType(e['value'], e)).toList())

    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Matrix &&
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
  FormElementWidget toWidget() {
    return MatrixWidget(label: label,
        visible: visible,
        required: required,
        name: name,
        value: value,
        showIfValueSelected: showIfValueSelected,
        showIfFieldValue: showIfFieldValue,
        showIfIsRequired: showIfIsRequired,
        maxRecordCount: maxRecordsCount,

        fields: List<FormElementWidget>.from(values.map((e) => e.toWidget())));
  }




  Matrix copyWith({
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
    int? maxRecordCount,
    List<IFormModel>? values,
    dynamic? value,
  }) {
    return Matrix(
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
      maxRecordsCount: maxRecordCount ?? this.maxRecordsCount,
      values: values ?? this.values,

      value: value ?? this.value,
    );
  }

  @override
  String valueToString() {
    return this.value.toString();
  }
}
