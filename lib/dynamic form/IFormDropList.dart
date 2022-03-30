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

@HiveType(typeId: 24)
class IFormDropList implements IFormModel {
  dynamic _parameters;

  @HiveField(1)

  List<DropDownItem> values = [];
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







 factory IFormDropList.fromJson(json){
    return IFormDropList(
        label: json['label'],
        deactivate: json['deactivate'],
        required: json['required'],
        isHidden: json['isHidden'],
        name: json['name'],
        isReadOnly: json['isReadOnly'],
        prompt: json['prompt'],
        values: List<DropDownItem>.from(json['values'].map((e) => DropDownItem.fromJson(e)).toList()),
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
  FormElement getFormElement({parameters}) {

    if (this.multiple == true) {
      return DrawMultiSelect(
        label: label,
        deactivate:deactivate ,
        required: required,
        isHidden: isHidden,
        name:name,
        isReadOnly: isReadOnly,
        prompt:prompt,
        items: values,
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
      return DrawChildList(
        label: label,
        deactivate:deactivate ,
        required: required,
        isHidden: isHidden,
        name:name,
        isReadOnly: isReadOnly,
        prompt:prompt,
        items: values,
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
        items: values,
        parentName: parentName,
        showIfIsRequired: showIfIsRequired,
        showIfFieldValue: showIfFieldValue,
        showIfValueSelected: showIfValueSelected,
        multiple: multiple,
        visible: showIfValueSelected == true  ? false : true,
        relatedToParent: this.relatedToParent,

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

  IFormDropList({
    required this.values,
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
    required this.showIfValueSelected,
    this.showIfFieldValue,
    this.showIfIsRequired,
  });

}
