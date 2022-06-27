import 'package:equatable/equatable.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/MatrixWidget.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

import '../../../Widgets/Matrix/MatrixRecordWidget.dart';

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
    return MatrixRecordWidget(
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
  MatrixRecordModel copyWith({
    dynamic value,
    List<IFormModel> ? fields
  }) {
    return MatrixRecordModel(
        value: value,
        fields: fields ?? this.fields.map((e) => e.copyWith()).toList()

    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [value,fields];
}