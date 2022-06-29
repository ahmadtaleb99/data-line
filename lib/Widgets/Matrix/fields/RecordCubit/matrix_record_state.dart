part of 'matrix_record_cubit.dart';

@immutable

class  MatrixRecordState{

 List<Matrix> matrixList;
 MatrixRecordModel ?  currentRecord ;
 int   index ;
 String   errorText ;
  MatrixRecordState({
      required this.matrixList,
    this.currentRecord,
    required this.index,
    required this.errorText
  });

  MatrixRecordState copyWith({
    List<Matrix>? matrixList,
    MatrixRecordModel? currentRecord,
    int ? index ,
    String ?  errorText

  }) {


    return MatrixRecordState(
      index: index ?? this.index,
      matrixList: matrixList ?? this.matrixList,
      currentRecord: currentRecord ?? this.currentRecord,
      errorText: errorText ?? this.errorText,
    );
  }
}
