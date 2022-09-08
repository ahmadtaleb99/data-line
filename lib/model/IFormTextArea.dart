import 'package:flutter/src/widgets/framework.dart';
import 'package:datalines/Widgets/text_area_widget.dart';
import 'package:datalines/Widgets/form_element_widget.dart';
import 'package:datalines/model/IFormModel.dart';
import 'package:hive/hive.dart';

part 'IFormTextArea.g.dart';

@HiveType(typeId: 49)
class IFormTextArea implements IFormModel {

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
  int minLength;
  @HiveField(12)
  int maxLength;


  @HiveField(13)
  dynamic value;
  IFormTextArea({
    this.value,
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
    required this.minLength,
    required this.maxLength,});

  factory IFormTextArea.fromJson(json) {
    return IFormTextArea(
        label: json['label'],
        required: json['required'],
      minLength: json['minlength'],
      maxLength: json['maxlength'],
        showIfIsRequired: json['showIfIsRequired'],
        showIfFieldValue: json['showIfFieldValue'],
        isHidden: json['isHidden'],
        isReadOnly: json['isReadOnly'],
        showIfValueSelected: json['showIfLogicCheckbox'],
        name: json['name'],
        visible: json['showIfLogicCheckbox'] == true ? false : true,
        deactivate: json['deactivate'], );
  }
  @override
  FormElementWidget toWidget({parameters}) {
    print('to widget :: ${this.visible}  ${this.maxLength}');
    return TextAreaWidget(
      minLength: this.minLength,
      maxLength: this.maxLength,
      label: this.label,
      required: this.required,
      showIfIsRequired: this.showIfIsRequired,
      showIfFieldValue: this.showIfFieldValue,
      visible:  this.visible,
      value: this.value,

      showIfValueSelected: this.showIfValueSelected,
      name: this.name,  );
  }

  @override
  Map<String, dynamic> fomrElementtoJson(FormElementWidget formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
  }

  IFormTextArea copyWith({
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
    int? minLength,
    int? maxLength,
    dynamic? value,
  }) {
    return IFormTextArea(
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
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
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
