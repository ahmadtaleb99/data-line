import 'package:equatable/equatable.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/MatrixCheckboxGroupWidget.dart';
import 'package:form_builder_test/dynamic%20form/CheckboxItem.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';


part 'MatrixCheckboxGroup.g.dart';



@HiveType(typeId: 65)
class MatrixCheckboxGroup  extends Equatable implements IFormModel {

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
     this.value,
  });

  factory MatrixCheckboxGroup.fromJson(dynamic json){
    return MatrixCheckboxGroup(name: json['fieldName'], label: json['label'],
        value: [],
        values: List<CheckboxItem>.from(json['multipleOptions'].map((e) => CheckboxItem.FromJson(e , json['fieldName'])).toList())

    );
  }


  @override
  @HiveField(4)
  var value;



  @override
  FormElementWidget toWidget() {
    // TODO: implement toWidget
    return MatrixCheckboxGroupWidget(label: label, name: name, children: values, value: value);

  }

  @override
  String ? valueToString() {

    return this.value != null ?( this.value.isEmpty ? null : this.value.toString()) : this.value;
  }

  @override
  IFormModel copyWith({
    String? name,
    String? label,
    dynamic value,
    List<CheckboxItem>? values
  }) {

    return MatrixCheckboxGroup(
      name: name ?? this.name,
      label: label ?? this.label,
      value: value  ?? this.value,


      values: values ?? this.values,

    );

  }
@override
// TODO: implement props
List<Object?> get props => [name,label,value,values];
  @override
  bool isValid() {
    // TODO: implement isValid
    return true;

  }
}
