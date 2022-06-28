part of 'matrix_record_cubit.dart';

@immutable

class  MatrixRecordState{
  // @override
  // // TODO: implement props
  // List<Object?> get props => [currentRecord,matrixList];

 List<Matrix> matrixList;
 MatrixRecordModel ?  currentRecord ;
 int   index ;
  MatrixRecordState({
      required this.matrixList,
    this.currentRecord,
    required this.index
  });

  MatrixRecordState copyWith({
    List<Matrix>? matrixList,
    MatrixRecordModel? currentRecord,
    int ? index ,
  }) {


    return MatrixRecordState(
      index: index ?? this.index,
      matrixList: matrixList ?? this.matrixList,
      currentRecord: currentRecord ?? this.currentRecord,
    );
  }
}
