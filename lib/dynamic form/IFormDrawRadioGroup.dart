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
  @HiveField(12)
  List<RadioItem> values;

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

  @HiveField(13)
  dynamic value;


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
  FormElement toWidget() {
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
