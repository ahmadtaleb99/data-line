import 'package:equatable/equatable.dart';
import 'package:form_builder_test/FormValidation.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/MatrixNumberWidget.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

import '../matrix.dart';

part 'MatrixNumber.g.dart';



@HiveType(typeId: 72)
class MatrixNumber extends Equatable  with FormValidation implements IFormModel  {

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

  var  value;

  bool isValid(){
    if(this.value == null)
      return true;
    var realValue = this.value as String;
    return   isNumeric(realValue) &&( realValue.isNotEmpty) ;

  }

  @override
  FormElementWidget toWidget() {
    return MatrixNumberWidget(label: label, name: name, value: value);
  }


  @override
  String ?  valueToString() {
    String ? realValue = this.value;
    if(realValue != null && realValue.isEmpty)
      return null;

    return realValue;
  }

  @override
  IFormModel copyWith({
    String? name,
    String? label,
    dynamic value,

  }) {

    return MatrixNumber(
      name: name ?? this.name,
      label: label ?? this.label,
      value: value  ?? this.value,


    );



  }
  @override
  // TODO: implement props
  List<Object?> get props => [name,label,value];

}
