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
  IFormModel copyWith({dynamic value}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  FormElementWidget toWidget() {
    throw UnimplementedError();

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
  String get label => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();


}