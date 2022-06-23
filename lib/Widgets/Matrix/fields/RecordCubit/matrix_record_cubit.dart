import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
            records: [], pressedItems: [], recordsModel: [], ));

  FormRepository _formRepository;

  void toggleExpanded(MatrixRecordWidget matrixRecordWidget, int index) {
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


    if (records.isEmpty) records.add(MatrixRecordModel(fields: matrix.values));

    emit(state.copyWith());
  }

  void addRecord(String matrixName) {


    List<MatrixRecordModel> list = List.from(state.recordsModel);

    var matrix = _formRepository.availableForms[1].fields.firstWhere((dynamic element) => element.name == matrixName) as Matrix;


    list.add(MatrixRecordModel(fields: matrix.values.map((e) => e.copyWith(value: null)).toList()));

    emit(state.copyWith(recordsModel: list));
  }

  void removeRecord(int index) {
    List<MatrixRecordModel> list = List.from(state.recordsModel);
    // matrix.records.add(MatrixRecordModel(fields: matrix.values));
    list.removeAt(index);
    emit(state.copyWith(recordsModel: list));
  }

  void  textFieldValueChanged(dynamic value,String fieldName,) {
    var tf = state.recordsModel[state.recordNumber].fields.firstWhere((dynamic element) => element.name == fieldName).value = value;
  }

 Future<DateTime?>  dateChanged(BuildContext context,fieldName) async {

    final date = await  showDatePicker(firstDate: DateTime(1940)
        , initialDate: DateTime(1999),
        lastDate: DateTime.now(), context: context);
    emit(state.copyWith( dateTime : date));

    state.recordsModel[state.recordNumber].fields.firstWhere((dynamic element) => element.name == fieldName).value = date;

    emit(state.copyWith( dateTime : date));

    return  date;



 }


  void set(int record){
    state.recordNumber = record;
  }


}
