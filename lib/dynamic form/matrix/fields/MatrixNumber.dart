import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/MatrixNumberWidget.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

import '../matrix.dart';

part 'MatrixNumber.g.dart';



@HiveType(typeId: 72)
class MatrixNumber implements IFormModel {

  @HiveField(1)
  String name;
  @HiveField(2)
  String label;
  MatrixNumber({
    required this.name,
    required this.label,
    this.value
  });

  factory MatrixNumber.fromJson(dynamic json){
    return MatrixNumber(name: json['fieldName'], label: json['label']);
  }


  @override
  @HiveField(3)

  var value;



  @override
  FormElementWidget toWidget() {
    return MatrixNumberWidget(label: label, name: name, value: value);
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
  }) {

    return MatrixNumber(
      name: name ?? this.name,
      label: label ?? this.label,
      value: value ?? this.value,

    );

  }


}
