import 'package:form_builder_test/domain/model/form_model.dart';

class MatrixRecord{
 final   Map<String,dynamic> valuesMap;

  MatrixRecord({
    required this.valuesMap,
  });

 MatrixRecord copyWith({
   Map<String,dynamic>? submission,
  }) {
    return MatrixRecord(
      submission: submission ?? this.valuesMap,
    );
  }
}