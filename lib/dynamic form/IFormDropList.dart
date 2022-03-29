import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/Widgets/DrawMultiSelect.dart';
import 'package:form_builder_test/dynamic%20form/DropDownItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';

class IFormDropList implements IFormModel {
  dynamic _parameters;
  List<DropDownItem> values = [];
  String label;
  String name;
  String prompt;
  bool deactivate;
  bool isHidden;
  bool multiple;
  bool required;
  bool isReadOnly;
  bool relatedToParent;
  String? parentName;
  bool? visible;
  bool showIfValueSelected;
  String? showIfFieldValue;
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
