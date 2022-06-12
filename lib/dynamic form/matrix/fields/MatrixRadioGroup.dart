import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:form_builder_test/dynamic%20form/RadioItem.dart';

import '../matrix.dart';

class MatrixRadioGroup implements IFormModel {

  String name;
  String label;
  List<RadioItem> values;
  MatrixRadioGroup({
    required this.name,
    required this.label,
    required this.values,
  });

  factory MatrixRadioGroup.fromJson(dynamic json){
    return MatrixRadioGroup(name: json['name'], label: json['label'], values: []);
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
