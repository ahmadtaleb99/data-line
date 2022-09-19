import 'package:equatable/equatable.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:hive_flutter/hive_flutter.dart';



part 'matrix_record_model.g.dart';
@HiveType(typeId: 31)
class MatrixRecordModel extends Equatable{


  @HiveField(1)
 final   Map<String,dynamic> valuesMap;

  const MatrixRecordModel({
    required this.valuesMap,
  });

 MatrixRecordModel copyWith({
   Map<String,dynamic>? valuesMap,
  }) {
    return MatrixRecordModel(
      valuesMap: valuesMap ?? this.valuesMap,
    );
  }



  areAllValuesNull(){
   return this.valuesMap.values.every((element) => element ==  null );
  }

  @override
  List<Object?> get props => [valuesMap];
}