import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

import '../matrix.dart';


part 'MatrixTextField.g.dart';



@HiveType(typeId: 60)
class MatrixTextField implements IFormModel {

  @HiveField(1)
  String name;
  @HiveField(2)
  String label;
  MatrixTextField({
    required this.name,
    required this.label,
  });

  factory MatrixTextField.fromJson(dynamic json){
    return MatrixTextField(name: json['name'], label: json['label']);
  }


  @override
  @HiveField(3)
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
