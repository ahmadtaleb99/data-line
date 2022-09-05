import 'package:equatable/equatable.dart';
import 'package:form_builder_test/domain/model/form_model.dart';

class MatrixRecordModel extends Equatable{
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
  List<Object?> get props => [valuesMap];
}