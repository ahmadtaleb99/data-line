import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/checkbox_group_widget.dart';
import 'package:form_builder_test/Widgets/checkbox_widget.dart';
import 'package:form_builder_test/Widgets/checkbox_group_item_widget.dart';
import 'package:form_builder_test/Widgets/form_element_widget.dart';
import 'package:form_builder_test/model/CheckboxItem.dart';
import 'package:hive/hive.dart';

import 'IFormModel.dart';

part 'IFormCheckBoxGroup.g.dart';

@HiveType(typeId: 42)
class IFormCheckBoxGroup extends IFormModel {
  List<CheckboxGroupItemWidget> WidgetitemsList = [];

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

  List<CheckboxItem> children;


  @HiveField(16)
  dynamic value;


  IFormCheckBoxGroup({
    required this.label,
    required this.name,
    required this.deactivate,
    required this.isHidden,
    required this.required,
    required this.children,
    required this.isReadOnly,
    this.visible,
    this.value,
    required this.showIfValueSelected,
    this.showIfFieldValue,
    this.showIfIsRequired,

    required this.minMaxCheckbox,
    this.minCheckedAllowed,
    this.maxCheckedAllowed,
    required this.other,

  }) : super( name: name,label: label) ;



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
      children: List<CheckboxItem>.from(parameters['values'].map((e) => CheckboxItem.FromJson(e , parameters['name'])).toList())

    );
  }





  @override
  FormElementWidget toWidget() {

    List<CheckboxGroupItemWidget> widgetChildrenList = [ ];
    for(var child in this.children){
      var newCheckBoxWidget = child.toWidget() as CheckboxGroupItemWidget ;

      if(value!= null ){
        var values = value as List<String>;
        values.contains(newCheckBoxWidget.value) ?  newCheckBoxWidget.isChecked = true :         newCheckBoxWidget.isChecked = false;
      }
      widgetChildrenList.add(newCheckBoxWidget);

    }



      return CheckboxGroupWidgetOld(
        label: this.label,
        required: this.required,
        isReadOnly: this.isReadOnly,
        showIfIsRequired:this.showIfIsRequired,
        showIfFieldValue: this.showIfFieldValue,
        showIfValueSelected: this.showIfValueSelected,
        name: this.name,
        value: this.value ?? <String>[],
        deactivated: this.deactivate,
        visible:  this.showIfValueSelected == true  ? false : true,
        isHidden: this.isHidden,
        deactivate: this.deactivate,
        children: widgetChildrenList,
        minMaxCheckbox: this.minMaxCheckbox,
        maxCheckedAllowed: this.maxCheckedAllowed,
        minCheckedAllowed: this.minCheckedAllowed,
        other:  this.other,


      );

  }



  @override
  Map<String, dynamic> fomrElementtoJson(FormElementWidget formElement) {
    var checkBoxGroup = formElement as CheckboxGroupWidgetOld;

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




  IFormCheckBoxGroup copyWith({
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
    bool? minMaxCheckbox,
    int? maxCheckedAllowed,
    int? minCheckedAllowed,
    bool? other,
    List<CheckboxItem> ? children,
    dynamic? value,
  }) {
    return IFormCheckBoxGroup(
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
      minMaxCheckbox:minMaxCheckbox?? this.minMaxCheckbox,
      maxCheckedAllowed: maxCheckedAllowed ?? this.maxCheckedAllowed,
      minCheckedAllowed:minCheckedAllowed ?? this.minCheckedAllowed,
      other:  other ??this.other,
      children: children ?? this.children,
    );
  }

  @override
  String valueToString() {
    return (value as List).join(',');
  }

  @override
  bool isValid() {
    // TODO: implement isValid
    throw UnimplementedError();
  }
}
