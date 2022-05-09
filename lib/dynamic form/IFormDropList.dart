import 'dart:developer';

import 'package:collection/src/iterable_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/Widgets/DrawMultiSelect.dart';
import 'package:form_builder_test/dynamic%20form/DropDownItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';


part 'IFormDropList.g.dart';

@HiveType(typeId: 44)
class IFormDropList  extends IFormModel  {
  dynamic _parameters;

  @HiveField(1)

  List<DropDownItem> items = [];
  @HiveField(2)
  String label;
  @HiveField(3)
  String name;
  @HiveField(4)
  String prompt;

  @HiveField(5)
  bool deactivate;

  @HiveField(6)
  bool isHidden;
  @HiveField(7)
  bool multiple;
  @HiveField(8)
  bool required;
  @HiveField(9)
  bool isReadOnly;
  @HiveField(10)
  bool relatedToParent;
  @HiveField(11)
  String? parentName;
  @HiveField(12)
  bool? visible;
  @HiveField(13)
  bool showIfValueSelected;
  @HiveField(14)
  String? showIfFieldValue;
  @HiveField(15)
  bool? showIfIsRequired;


  @HiveField(16)
  dynamic value;






 factory IFormDropList.fromJson(json){
    return IFormDropList(
        label: json['label'],
        deactivate: json['deactivate'],
        required: json['required'],
        isHidden: json['isHidden'],
        name: json['name'],
        isReadOnly: json['isReadOnly'],
        prompt: json['prompt'],
        items: List<DropDownItem>.from(json['values'].map((e) => DropDownItem.fromJson(e)).toList()),
        parentName: json['relatedListCheckbox'] ?  json['relatedListFieldName'] : null,
        showIfIsRequired: json['showIfIsRequired'],
        showIfFieldValue: json['showIfFieldValue'],
        showIfValueSelected: json['showIfLogicCheckbox'],
        multiple: json['multiple'],

        relatedToParent: json['relatedListCheckbox'],
      visible:  json['showIfLogicCheckbox'] == true  ? false : true,

    );
  }


  @override
  FormElement toWidget({parameters}) {
    var childItems;
    var parent;
    if(value != null &&relatedToParent){
      if(value is List)
       parent = items.firstWhere((element) => element.value ==  value.first).parent;
      if(value is String)
         parent = items.firstWhere((element) => element.value ==  value).parent;


      childItems =  items.where((item) => item.parent == parent).toList();
    }

    if (this.multiple == true) {
      return DrawMultiSelect(
        selectedValues: value ?? [],
        label: label,
        deactivate:deactivate ,
        required: required,
        isHidden: isHidden,
        name:name,
        value: value,
        isReadOnly: isReadOnly,
        prompt:prompt,
        items: relatedToParent ? (value != null ? childItems : []) : items,
        parentName: parentName,
        showIfIsRequired: showIfIsRequired,
        showIfFieldValue: showIfFieldValue,
        showIfValueSelected: showIfValueSelected,
        multiple: multiple,
        relatedToParent: relatedToParent,

        visible: showIfValueSelected == true  ? false : true,

      );
    }
    if (this.relatedToParent) {

      print(value);
      return DrawChildList(
        label: label,
        deactivate:deactivate ,
        required: required,
        isHidden: isHidden,
        name:name,
        isReadOnly: isReadOnly,
        prompt:prompt,
        value: value,
        //i
        items:  value != null ? childItems : [],
        parentName: parentName,
        showIfIsRequired: showIfIsRequired,
        showIfFieldValue: showIfFieldValue,
        showIfValueSelected: showIfValueSelected,
        multiple: multiple,
        visible: showIfValueSelected == true  ? false : true,

      );

    } else
      return DrawDropDown(
        label: label,
        deactivate:deactivate ,
        required: required,
        isHidden: isHidden,
        name:name,
        isReadOnly: isReadOnly,
        prompt:prompt,
        items: items,
        parentName: parentName,
        value: this.value,
        showIfIsRequired: showIfIsRequired,
        showIfFieldValue: showIfFieldValue,
        showIfValueSelected: showIfValueSelected,
        multiple: multiple,
        visible: showIfValueSelected == true  ? false : true,
        relatedToParent: this.relatedToParent,

    );
  }


  @override
  Map<String, dynamic> fomrElementtoJson(FormElement formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
  }

  IFormDropList({
    required this.items,
    required this.label,
    required this.parentName,
    required this.name,
    required this.deactivate,
    required this.isHidden,
    required this.prompt,
    required this.multiple,
    required this.required,
    required this.isReadOnly,
    required this.relatedToParent,
    this.visible,
    this.value,
    required this.showIfValueSelected,
    this.showIfFieldValue,
    this.showIfIsRequired,
  });
  IFormDropList copyWith({
    String? label,
    String? name,
    bool? deactivate,
    bool? isHidden,
    bool? required,
    bool? isReadOnly,
    bool? visible,
    bool? multiple,
    bool? showIfValueSelected,
    String? showIfFieldValue,
    bool? showIfIsRequired,
    bool? relatedToParent,
    String? parentName,
    String? prompt,
    List<DropDownItem> ?  items ,

    dynamic? value,
  }) {
    return IFormDropList(
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
      relatedToParent: relatedToParent ?? this.relatedToParent,
      parentName: parentName ?? this.parentName,
      items: items ?? this.items,
      prompt: prompt ?? this.prompt,
      multiple: multiple ?? this.multiple,
    );
  }



  @override
  String valueToString() {
    String valueToString;
    if(this.value is List){
      valueToString =  (this.value as List).join(',');
return valueToString;
    }

    return value.toString();
  }
}
