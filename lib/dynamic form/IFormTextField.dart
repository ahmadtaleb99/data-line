import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

part 'IFormTextField.g.dart';


@HiveType(typeId: 50)
class IFormTextField implements IFormModel {
  dynamic _parameters;
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



  IFormTextField({
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
  });

  factory IFormTextField.fromJson(json) {
    return IFormTextField(
      label: json['label'],
      required: json['required'],
      showIfIsRequired: json['showIfIsRequired'],
      showIfFieldValue: json['showIfFieldValue'],
      isHidden: json['isHidden'],
      isReadOnly: json['isReadOnly'],
      showIfValueSelected: json['showIfLogicCheckbox'],
      name: json['name'],
      deactivate: json['deactivate'], );
  }

  @override
  FormElement toWidget({parameters}) {
    return DrawTextField(

      label: this.label,
      required: this.required,
      showIfValueSelected: this.showIfValueSelected,
      showIfFieldValue: this.showIfFieldValue,
      showIfIsRequired: this.showIfIsRequired,
      name: this.name,
      visible: this.showIfValueSelected == true && value == null ? false : true,
      value: this.value,
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


}
