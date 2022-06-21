part of 'matrix_record_cubit.dart';

@immutable

class  MatrixRecordState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [records,pressedItems,recordsModel];

 List<MatrixRecordWidget> records;
 List<MatrixRecordModel> recordsModel;
 List<MatrixRecordWidget>   pressedItems = [];
 List<bool>   isExpanded = [];
 int recordNumber = 0 ;

  MatrixRecordState({
    required this.records,
    required this.isExpanded,
    required this.recordsModel,
    required    this.pressedItems,
  });

  MatrixRecordState copyWith({
    List<MatrixRecordWidget>? records,
    List<MatrixRecordModel>? recordsModel,
    List<MatrixRecordWidget>? pressedItems,
    List<bool>? isExpanded,
  }) {
    return MatrixRecordState(
      records: records ?? this.records,
      recordsModel: recordsModel ?? this.recordsModel,
      pressedItems: pressedItems ?? this.pressedItems,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
