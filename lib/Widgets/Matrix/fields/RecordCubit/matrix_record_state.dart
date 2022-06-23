part of 'matrix_record_cubit.dart';

@immutable

class  MatrixRecordState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [records,pressedItems,recordsModel,dateTime];

 List<MatrixRecordWidget> records;
 List<MatrixRecordModel> recordsModel;
 List<MatrixRecordWidget>   pressedItems = [];
 int recordNumber = 0 ;
 DateTime? dateTime  ;

  MatrixRecordState({
    required this.records,
    required this.recordsModel,
     this.dateTime,
    required    this.pressedItems,
  });

  MatrixRecordState copyWith({
    List<MatrixRecordWidget>? records,
    List<MatrixRecordModel>? recordsModel,
    List<MatrixRecordWidget>? pressedItems,
    List<bool>? isExpanded,
    DateTime? dateTime

  }) {
    return MatrixRecordState(
      records: records ?? this.records,
      recordsModel: recordsModel ?? this.recordsModel,
      pressedItems: pressedItems ?? this.pressedItems,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
