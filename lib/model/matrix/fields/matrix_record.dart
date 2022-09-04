import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:form_builder_test/Widgets/form_element_widget.dart';
import 'package:form_builder_test/Widgets/Matrix/matrix_widget.dart';
import 'package:form_builder_test/model/IFormModel.dart';
import 'package:hive/hive.dart';

import '../../../Widgets/Matrix/matrix_record_widget.dart';

part 'matrix_record.g.dart';

@HiveType(typeId: 67)
class MatrixRecordModel  extends Equatable implements IFormModel {

  @HiveField(1)
  List<IFormModel> fields;


  @override
  @HiveField(2)
  var value;


  @override
  FormElementWidget toWidget() {
    return oldMatrixRecordWidget(
        children: this.fields, index: 2, matrixName: this.name);
  }

  @override
  String valueToString() {
    // TODO: implement valueToString
    throw UnimplementedError();
  }

  MatrixRecordModel({
    required this.fields,
    this.value,
  });

  @override
  // TODO: implement label
  String get label => 'throw UnimplementedError()';

  @override
  // TODO: implement name
  String get name => ' throw UnimplementedError()';
  @override
  // TODO: implement stringify
  bool? get stringify => true;
  @override
  MatrixRecordModel copyWith({
    dynamic value,
    List<IFormModel> ? fields
  }) {
    return MatrixRecordModel(
        value: value ?? this.value,
        fields: fields ?? this.fields.map((e) => e.copyWith()).toList()

    );
  }
  @override
  bool isValid() {
    // TODO: implement isValid
    return true;

  }
  @override
  // TODO: implement props
  List<Object?> get props => [value,fields];


  bool isEmpty () {
    for (IFormModel field in this.fields){
      if(field.valueToString() != null)
          return false;
    }

    return true;
  }


}