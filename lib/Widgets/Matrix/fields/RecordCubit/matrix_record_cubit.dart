import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/MatrixRecordWidget.dart';
import 'package:form_builder_test/data/FormRepository.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/matrix_record.dart';
import 'package:meta/meta.dart';

import '../../../../dynamic form/matrix/matrix.dart';

part 'matrix_record_state.dart';

class MatrixRecordCubit extends Cubit<MatrixRecordState> {
  MatrixRecordCubit(this._formRepository)
      : super(MatrixRecordState(
            records: [], pressedItems: [], recordsModel: [], isExpanded: []));

  FormRepository _formRepository;

  void toggleExpanded(MatrixRecordWidget matrixRecordWidget, int index) {
    state.isExpanded[index] = !state.isExpanded[index];
    List<MatrixRecordWidget> list = List.from(state.pressedItems);

    list.contains(matrixRecordWidget)
        ? list.remove(matrixRecordWidget)
        : list.add(matrixRecordWidget);

    emit(state.copyWith(pressedItems: list));
  }

  void fetchRecords(String name) {
    var matrix = (_formRepository.availableForms[1].fields
        .firstWhere((dynamic element) => element.name == name) as Matrix);

    var records = matrix.records;
    emit(state.copyWith(recordsModel: records));

    log('hoin');

    if (records.isEmpty) records.add(MatrixRecordModel(fields: matrix.values));
    log(records.length.toString());
    for (int i = 0; i <= records.length; i++) {
      state.isExpanded.add(false);

      log('hoin $i');

      print('asd');
    }
    emit(state.copyWith());
  }

  void addRecord(String matrixName) {

    log(matrixName);
    log('matrixName');
    List<MatrixRecordModel> list = List.from(state.recordsModel);

    var matrix = _formRepository.availableForms[1].fields.firstWhere((dynamic element) => element.name == matrixName) as Matrix;


    list.add(MatrixRecordModel(fields: matrix.values.map((e) => e.copyWith()).toList()..forEach((element) {element.value = null;})));

    emit(state.copyWith(recordsModel: list));
  }

  void removeRecord(int index) {
    List<MatrixRecordModel> list = List.from(state.recordsModel);
    // matrix.records.add(MatrixRecordModel(fields: matrix.values));
    list.removeAt(index);
    emit(state.copyWith(recordsModel: list));
  }

  void textFieldValueChanged(String value,String name,) {


    var tf = state.recordsModel[state.recordNumber].fields.firstWhere((dynamic element) => element.name == name).value = value;

  }

  void set(int record){
    print(record);
    state.recordNumber = record;
  }
}
