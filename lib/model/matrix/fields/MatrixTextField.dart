import 'package:equatable/equatable.dart';
import 'package:form_builder_test/Widgets/form_element_widget.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/matrix_text_field_widget.dart';
import 'package:form_builder_test/model/IFormModel.dart';
import 'package:hive/hive.dart';

import '../matrix.dart';


part 'MatrixTextField.g.dart';



@HiveType(typeId: 60)
class MatrixTextField extends Equatable implements IFormModel {

  @HiveField(1)
  String name;
  @HiveField(2)
  String label;
  MatrixTextField({
    required this.name,
    required this.label,
     this.value
  });

  factory MatrixTextField.fromJson(dynamic json){
    return MatrixTextField(name: json['fieldName'], label: json['label']);
  }


  @override
  @HiveField(3)
  var value;



  @override
  FormElementWidget toWidget() {

    return MatrixTextFieldWidget(label: label, name: name, value: value)  ;
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

    return MatrixTextField(
        name: name ?? this.name,
      label: label ?? this.label,
      value: value  ?? this.value,


    );

  }
  @override
  bool isValid() {
    // TODO: implement isValid
    return true;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [name,label,value];
}
