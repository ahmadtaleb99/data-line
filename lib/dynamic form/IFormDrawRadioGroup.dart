import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawRadioGroup.dart';
import 'package:form_builder_test/Widgets/DrawRadioItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/RadioItem.dart';

import 'formable.dart';

class IFormDrawRadioGroup implements IFormModel {
  List<RadioItem> values;
  String label;
  String name;
  bool deactivate;
  bool isHidden;
  bool required;
  bool isReadOnly;
  bool? visible;
  bool showIfValueSelected;
  String? showIfFieldValue;
  bool? showIfIsRequired;
  bool other;

  factory IFormDrawRadioGroup.FromJson({ required Map<String,dynamic>  parameters}) {
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
        values: List<RadioItem>.from(parameters['values']).map((e) => RadioItem.fromJson(e , parameters['name'])).toList()

    );
  }




  @override
  FormElement formElementFromJson() {
    List<DrawRadioItem> children = [];
    for (var radio in this.values) {
      var newRadio = DrawRadioItem(
          label: radio.label, value: radio.label, parent: this.name);

      children.add(newRadio);
    }
    if (this.other == true)
      children.add(
        DrawRadioItem(label: 'other', value: 'other', parent: this.name),
      );

    return DrawRadioGroup(
        label: this.label,
        name: this.name,
        required: this.required,
        other: this.other,
        showIfValueSelected: this.showIfValueSelected,
        showIfIsRequired: this.showIfIsRequired,
        showIfFieldValue: this.showIfFieldValue,
        children: children);
  }



  @override
  Map<String, dynamic> fomrElementtoJson(FormElement formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
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
    required this.showIfValueSelected,
    this.showIfFieldValue,
    this.showIfIsRequired,
    required this.other,
  });
}
