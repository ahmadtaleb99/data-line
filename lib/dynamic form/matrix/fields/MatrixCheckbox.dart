import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

import '../matrix.dart';

part 'MatrixCheckbox.g.dart';

@HiveType(typeId: 66)

class MatrixCheckbox implements IFormModel {

  @HiveField(1)
  String name;
  @HiveField(2)
  String label;
  MatrixCheckbox({
    required this.name,
    required this.label,
  });

  factory MatrixCheckbox.fromJson(dynamic json){
    return MatrixCheckbox(name: json['name'], label: json['label']);
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
