import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/MatrixWidget.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

import '../../../Widgets/Matrix/MatrixRecordWidget.dart';

part 'matrix_record.g.dart';

@HiveType(typeId: 67)
class MatrixRecordModel implements IFormModel{

  @HiveField(1)
   List<IFormModel> fields;




  @override
  @HiveField(2)
  var value;

  @override
  IFormModel copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  FormElementWidget toWidget() {
   return MatrixRecord( children: fields.map((e) => e.toWidget()).toList());
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
}