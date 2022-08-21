import 'package:equatable/equatable.dart';
import 'package:form_builder_test/Widgets/form_element_widget.dart';
import 'package:form_builder_test/Widgets/Matrix/matrix_widget.dart';
import 'package:form_builder_test/model/IFormModel.dart';
import 'package:form_builder_test/model/matrix/fields/MatrixCheckboxGroup.dart';
import 'package:form_builder_test/model/matrix/fields/MatrixDatePicker.dart';
import 'package:form_builder_test/model/matrix/fields/MatrixDropDown.dart';
import 'package:form_builder_test/model/matrix/fields/MatrixNumber.dart';
import 'package:form_builder_test/model/matrix/fields/MatrixRadioGroup.dart';
import 'package:form_builder_test/model/matrix/fields/matrix_record.dart';
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
class Matrix extends Equatable  implements IFormModel {

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


    String error ='';
  @HiveField(14)
   List<MatrixRecordModel> records;

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
    required this.records,
    required this.maxRecordsCount,
    required this.values

  });

  factory Matrix.fromJson(json) {
    return Matrix(
      records: [],
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
  FormElementWidget toWidget() {
    return MatrixWidget(label: label,
        visible: visible,
        required: required,
        name: name,

        value: value,
        records: this.records.map((e) => e.toWidget()).toList().cast(),
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
      records: records.map((e) => e.copyWith()).toList()   ,
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

  @override
  // TODO: implement props
  List<Object?> get props =>  [label,name,deactivate,isHidden,required,
    isReadOnly,visible,showIfValueSelected,showIfFieldValue,showIfIsRequired,value,values,maxRecordsCount,records];
  @override
  bool isValid() {
    // TODO: implement isValid
    throw UnimplementedError();
  }

}
