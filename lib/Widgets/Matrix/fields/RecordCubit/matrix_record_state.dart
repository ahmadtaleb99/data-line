part of 'matrix_record_cubit.dart';

@immutable

class  MatrixRecordState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [records,pressedItems];

 List<MatrixRecordWidget> records;
 List<MatrixRecordWidget>   pressedItems = [];

  MatrixRecordState({
    required this.records,
    required    this.pressedItems,
  });

  MatrixRecordState copyWith({
    List<MatrixRecordWidget>? records,
    List<MatrixRecordWidget>? pressedItems,
  }) {
    return MatrixRecordState(
      records: records ?? this.records,
      pressedItems: pressedItems ?? this.pressedItems,
    );
  }
}
