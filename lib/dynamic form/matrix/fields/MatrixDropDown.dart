import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/CheckboxItem.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:form_builder_test/dynamic%20form/RadioItem.dart';
import 'package:hive/hive.dart';

import '../../DropDownItem.dart';
import '../matrix.dart';


part 'MatrixDropDown.g.dart';


@HiveType(typeId: 63)

class MatrixDropDown implements IFormModel {

  @HiveField(1)
  String name;


  @HiveField(2)

  String label;


  @HiveField(3)
  List<DropDownItem> values;


  MatrixDropDown({
    required this.name,
    required this.label,
    required this.values,
  });

  factory MatrixDropDown.fromJson(dynamic json){
    return MatrixDropDown(name: json['fieldName'], label: json['label'],
      values: List<DropDownItem>.from(json['values'].map((e) => DropDownItem.fromJson(e)).toList()),

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
