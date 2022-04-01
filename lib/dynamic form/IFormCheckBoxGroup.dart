import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckbox.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/CheckboxItem.dart';
import 'package:hive/hive.dart';

import 'IFormModel.dart';

part 'IFormCheckBoxGroup.g.dart';

@HiveType(typeId: 22)
class IFormCheckBoxGroup implements IFormModel {
  List<DrawCheckboxGroupItem> WidgetitemsList = [];

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
   bool minMaxCheckbox;
  @HiveField(11)
   int? minCheckedAllowed;

  @HiveField(12)

  int? maxCheckedAllowed;
  @HiveField(13)

  bool? showIfIsRequired;
  @HiveField(14)

  bool other;
  @HiveField(15)

  List<CheckboxItem> values;




  IFormCheckBoxGroup({
    required this.label,
    required this.name,
    required this.deactivate,
    required this.isHidden,
    required this.required,
    required this.values,
    required this.isReadOnly,
    this.visible,
    required this.showIfValueSelected,
    this.showIfFieldValue,
    this.showIfIsRequired,

    required this.minMaxCheckbox,
    this.minCheckedAllowed,
    this.maxCheckedAllowed,
    required this.other,

  });


  factory IFormCheckBoxGroup.fromJson(parameters) {
    return IFormCheckBoxGroup(
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
      minMaxCheckbox: parameters['minMaxCheckbox'],
      minCheckedAllowed: parameters['minMaxCheckbox'] ? parameters['checkboxMinValue'] : null ,
      maxCheckedAllowed: parameters['minMaxCheckbox'] ? parameters['checkboxMaxValue'] : null,
        other: parameters['other'],
      values: List<CheckboxItem>.from(parameters['values'].map((e) => CheckboxItem.FromJson(e , parameters['name'])).toList())

    );
  }





  @override
  FormElement toWidget() {


    for (var checkBox in this.values) {
      var item = DrawCheckboxGroupItem(label: checkBox.label,
        value: checkBox.value,
        groupName: checkBox.groupName,

      );
      WidgetitemsList.add(item);
    }

      return DrawCheckboxGroup(
        label: this.label,
        required: this.required,
        isReadOnly: this.isReadOnly,
        showIfIsRequired:this.showIfIsRequired,
        showIfFieldValue: this.showIfFieldValue,
        showIfValueSelected: this.showIfValueSelected,
        name: this.name,
        deactivated: this.deactivate,
        visible:  this.showIfValueSelected == true  ? false : true,
        isHidden: this.isHidden,
        deactivate: this.deactivate,
        children: this.WidgetitemsList,
        minMaxCheckbox: this.minMaxCheckbox,
        maxCheckedAllowed: this.maxCheckedAllowed,
        minCheckedAllowed: this.minCheckedAllowed,
        other:  this.other,

      );

  }



  @override
  Map<String, dynamic> fomrElementtoJson(FormElement formElement) {
    var checkBoxGroup = formElement as DrawCheckboxGroup;

    return {
      'type'  : 'email',
      'name' : checkBoxGroup.name,
      'label' : checkBoxGroup.label,
      'deactivate' : checkBoxGroup.deactivate,
      'required' : checkBoxGroup.required,
      'isHidden' : checkBoxGroup.isHidden,
      'isReadOnly' : checkBoxGroup.isReadOnly,
      'showIfLogicCheckBox' : checkBoxGroup.showIfValueSelected,
      'showIfIsRequired' : checkBoxGroup.showIfIsRequired,


      'minMaxCheckbox': checkBoxGroup.minMaxCheckbox,
      'checkboxMinValue' : checkBoxGroup.minMaxCheckbox,
      'checkboxMaxValue' : checkBoxGroup.maxCheckedAllowed,
    };
  }
}
