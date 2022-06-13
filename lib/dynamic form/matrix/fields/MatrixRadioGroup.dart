import 'package:form_builder_test/Widgets/IDrawable.dart';
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
  });

  factory MatrixRadioGroup.fromJson(dynamic json){
    return MatrixRadioGroup(name: json['fieldName'], label: json['label'],
        values: List<RadioItem>.from(json['values'].map((e) => RadioItem.fromJson(e , json['name'])).toList())

    );
  }


  @override
  @HiveField(4)

  var value;



  @override
  FormElementWidget toWidget() {
    // TODO: implement toWidget
    throw UnimplementedError();
  }

  @override
  String valueToString() {
    // TODO: implement valueToString
    throw UnimplementedError();
  }

  @override
  IFormModel copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }


}
