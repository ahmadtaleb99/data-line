part of 'matrix_record_cubit.dart';

@immutable

class  MatrixRecordState{
  // @override
  // // TODO: implement props
  // List<Object?> get props => [currentRecord,matrixList];

 List<Matrix> matrixList;
 MatrixRecordModel ?  currentRecord ;
  MatrixRecordState({
      required this.matrixList,
    this.currentRecord,
  });

  MatrixRecordState copyWith({
    List<Matrix>? matrixList,
    MatrixRecordModel? currentRecord,
  }) {


    return MatrixRecordState(
      matrixList: matrixList ?? this.matrixList,
      currentRecord: currentRecord ?? this.currentRecord,
    );
  }
}
