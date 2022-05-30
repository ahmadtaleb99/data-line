import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawRadioGroup.dart';
import 'package:form_builder_test/Widgets/DrawRadioItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:form_builder_test/dynamic%20form/RadioItem.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';
import 'IFormModel.dart';

part 'IFormDrawRadioGroup.g.dart';

@HiveType(typeId: 43)
class IFormDrawRadioGroup extends IFormModel {

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
  bool other;




  @HiveField(12)
  List<RadioItem> values;

  @HiveField(13)
  dynamic value;

  @HiveField(14)
  String ? otherValue;

  @HiveField(15)
  bool ? isOtherSelected;
  factory IFormDrawRadioGroup.fromJson(parameters) {

    return IFormDrawRadioGroup(

        label: parameters['label'],
        required: parameters['required'],
        showIfIsRequired: parameters['showIfIsRequired'],
        showIfFieldValue: parameters['showIfFieldValue'],
          isHidden: parameters['isHidden'],
        isReadOnly: parameters['isReadOnly'],
        showIfValueSelected: parameters['showIfLogicCheckbox'],
        name: parameters['name'],
        visible: parameters['showIfLogicCheckbox'] == true ? false : true,
        deactivate: parameters['deactivate'],
        other: parameters['other'],
        values: List<RadioItem>.from(parameters['values'].map((e) => RadioItem.fromJson(e , parameters['name'])).toList()

    ));
  }




  @override
  FormElementWidget toWidget() {
    var groupValue;
    if(value != null ) {
      if( isOtherSelected == true ) {
        groupValue = 'other';
      }
     else groupValue = value;
    }
    List<DrawRadioItem> children = [];
    for (var radio in this.values) {
      var newRadio = DrawRadioItem(groupValue: groupValue,
          label: radio.label, value: radio.label, parent: this.name);

      children.add(newRadio);
    }
    if (this.other == true)
      children.add(
        DrawRadioItem(        groupValue: groupValue,
            label: 'other', value: 'other', parent: this.name),
      );

    return DrawRadioGroup(
      otherValue: this.isOtherSelected != null && this.isOtherSelected  == true  ? value : null,
      value: value,
        label: this.label,
        name: this.name,
        required: this.required,
        isOtherSelected: this.isOtherSelected ?? false,
        other: this.other,
        showIfValueSelected: this.showIfValueSelected,
        showIfIsRequired: this.showIfIsRequired,
        showIfFieldValue: this.showIfFieldValue,
        children: children);
  }




  IFormDrawRadioGroup({
    required this.values,
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
    required this.other,
  });


  IFormDrawRadioGroup copyWith({
    dynamic? parameters,
    String? label,
    String? name,
    bool? deactivate,
    bool? isHidden,
    bool? required,
    bool? isReadOnly,
    bool? visible,
    bool? other,
    bool? showIfValueSelected,
    String? showIfFieldValue,
    bool? showIfIsRequired,
    List<RadioItem>  ? values,
    dynamic? value,
  }) {
    return IFormDrawRadioGroup(
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
      value: value ?? this.value, other: other ?? this.other, values: values ?? this.values,
    );
  }


  @override
  String valueToString() {
    return this.value.toString();
  }
}
