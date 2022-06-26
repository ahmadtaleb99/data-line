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
 bool recordAdded;

  MatrixRecordState({
    required this.records,
    required this.recordsModel,
     this.dateTime,
     this.recordAdded = false,
    required    this.pressedItems,
  });

  MatrixRecordState copyWith({
    List<MatrixRecordWidget>? records,
    List<MatrixRecordModel>? recordsModel,
    List<MatrixRecordWidget>? pressedItems,
    int? recordNumber,
    DateTime? dateTime,
    bool? recordAdded,
  }) {
    return MatrixRecordState(
      records: records ?? this.records,
      recordsModel: recordsModel ?? this.recordsModel,
      pressedItems: pressedItems ?? this.pressedItems,
      dateTime: dateTime ?? this.dateTime,
      recordAdded: recordAdded ?? this.recordAdded,
    );
  }
}
