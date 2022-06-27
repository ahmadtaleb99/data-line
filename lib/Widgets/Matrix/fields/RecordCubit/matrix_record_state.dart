part of 'matrix_record_cubit.dart';

@immutable

class  MatrixRecordState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [recordsModel,currentRecord,matrixList];

 List<MatrixRecordModel> recordsModel;
 List<Matrix> matrixList;
 MatrixRecordModel ?  currentRecord ;
  MatrixRecordState({
    required this.recordsModel,
      required this.matrixList,
    this.currentRecord,
  });

  MatrixRecordState copyWith({
    List<MatrixRecordWidget>? records,
    List<MatrixRecordModel>? recordsModel,
    List<MatrixRecordWidget>? pressedItems,
    int? recordNumber,
    bool? recordAdded,
    List<Matrix>? matrixList,
    MatrixRecordModel? currentRecord,
  }) {

    return MatrixRecordState(
      recordsModel: recordsModel ?? this.recordsModel,
      matrixList: matrixList ?? this.matrixList,
      currentRecord: currentRecord ?? this.currentRecord,
    );
  }
}
