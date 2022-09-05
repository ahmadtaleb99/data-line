import 'package:form_builder_test/domain/model/form_model.dart';

class MatrixRecordModel{
 final   Map<String,dynamic> valuesMap;

  MatrixRecordModel({
    required this.valuesMap,
  });

 MatrixRecordModel copyWith({
   Map<String,dynamic>? valuesMap,
  }) {
    return MatrixRecordModel(
      valuesMap: valuesMap ?? this.valuesMap,
    );
  }

 @override
  String toString() {
    return 'MatrixRecordModel{valuesMap: $valuesMap}';
  }
}