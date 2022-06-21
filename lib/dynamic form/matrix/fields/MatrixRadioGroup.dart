  import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/MatrixRadioGroupWidget.dart';
import 'package:form_builder_test/dynamic%20form/CheckboxItem.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:form_builder_test/dynamic%20form/RadioItem.dart';
import 'package:hive/hive.dart';

import '../matrix.dart';


part 'MatrixRadioGroup.g.dart';



@HiveType(typeId: 71)
class MatrixRadioGroup implements IFormModel {


  @HiveField(1)
  String name;


  @HiveField(2)

  String label;


  @HiveField(3)

  List<RadioItem> values;


  MatrixRadioGroup({
    required this.name,
    required this.label,
    required this.values,
    this.value
  });

  factory MatrixRadioGroup.fromJson(dynamic json){
    return MatrixRadioGroup(name: json['fieldName'], label: json['label'],
        values: List<RadioItem>.from(json['multipleOptions'].map((e) => RadioItem.fromJson(e , json['fieldName'])).toList())

    );
  }


  @override
  @HiveField(4)

  var value;



  @override
  FormElementWidget toWidget() {
    return MatrixRadioGroupWidget(label: label, name: name, children: values, value: value);
  }

  @override
  String valueToString() {
    // TODO: implement valueToString
    throw UnimplementedError();
  }

  @override
  IFormModel copyWith({
    String? name,
    String? label,
    String? value,
    List<RadioItem>? values
  }) {

    return MatrixRadioGroup(
      name: name ?? this.name,
      label: label ?? this.label,
      value: value ?? this.value,
      values: values ?? this.values,

    );

  }


}
