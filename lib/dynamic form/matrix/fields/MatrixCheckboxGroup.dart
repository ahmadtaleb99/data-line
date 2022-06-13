import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/CheckboxItem.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';


part 'MatrixCheckboxGroup.g.dart';



@HiveType(typeId: 65)
class MatrixCheckboxGroup implements IFormModel {

  @HiveField(1)
  String name;


  @HiveField(2)

  String label;


  @HiveField(3)
  List<CheckboxItem> values;


  MatrixCheckboxGroup({
    required this.name,
    required this.label,
    required this.values,
  });

  factory MatrixCheckboxGroup.fromJson(dynamic json){
    return MatrixCheckboxGroup(name: json['fieldName'], label: json['label'],
        values: List<CheckboxItem>.from(json['values'].map((e) => CheckboxItem.FromJson(e , json['name'])).toList())

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
