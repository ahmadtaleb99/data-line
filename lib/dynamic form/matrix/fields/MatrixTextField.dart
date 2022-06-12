import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';

import '../matrix.dart';

class MatrixTextField implements IFormModel {

  String name;
  String label;
  MatrixTextField({
    required this.name,
    required this.label,
  });

  factory MatrixTextField.fromJson(dynamic json){
    return MatrixTextField(name: json['name'], label: json['label']);
  }


  @override
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
