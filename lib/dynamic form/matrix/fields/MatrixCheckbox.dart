import 'package:equatable/equatable.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/MatrixCheckboxWidget.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

import '../matrix.dart';

part 'MatrixCheckbox.g.dart';

@HiveType(typeId: 66)

class MatrixCheckbox extends Equatable implements IFormModel {

  @HiveField(1)
  String name;
  @HiveField(2)
  String label;
  MatrixCheckbox({
    required this.name,
    required this.label,
     this.value,
  });

  factory MatrixCheckbox.fromJson(dynamic json){
    return MatrixCheckbox(name: json['fieldName'], label: json['label']);
  }


  @override
  @HiveField(4)
  var value;



  @override
  FormElementWidget toWidget() {
    // TODO: implement toWidget
    return MatrixCheckboxWidget(label: label, name: name, value: value);
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
    dynamic value,
  }) {

    return MatrixCheckbox(
      name: name ?? this.name,
      label: label ?? this.label,
      value: value  ?? this.value,


    );

  }

  @override
  // TODO: implement props
  List<Object?> get props => [name,label,value];
  @override
  bool isValid() {
    // TODO: implement isValid
    return true;

  }

}
