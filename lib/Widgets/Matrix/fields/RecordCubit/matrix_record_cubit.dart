import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/MatrixRecordWidget.dart';
import 'package:form_builder_test/data/FormRepository.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/matrix_record.dart';
import 'package:meta/meta.dart';

import '../../../../dynamic form/matrix/matrix.dart';

part 'matrix_record_state.dart';

class MatrixRecordCubit extends Cubit<MatrixRecordState> {
  MatrixRecordCubit(this._formRepository) : super(MatrixRecordState(records: [],pressedItems: [],recordsModel: [], isExpanded: []));

    FormRepository _formRepository;



  void toggleExpanded(MatrixRecordWidget matrixRecordWidget,int index){



      state.isExpanded[index] = !state.isExpanded[index];
    List<MatrixRecordWidget> list = List.from(state.pressedItems);

    list.contains(matrixRecordWidget) ?
    list.remove(matrixRecordWidget)
        : list.add(matrixRecordWidget);


    emit(state.copyWith(pressedItems: list));
  }


  void fetchRecords (String name){

    var matrix = (_formRepository.availableForms[1].fields.firstWhere((dynamic element) => element.name == name) as Matrix);

    var records = matrix.records;
    emit(state.copyWith(recordsModel: records));


    log('hoin');

    if(records.isEmpty)
      records.add(MatrixRecordModel(fields:matrix.values));
    log(records.length.toString());
    for(int i = 0 ; i <=  records.length ; i++){
      state.isExpanded.add(false);

      log('hoin $i');

      print('asd');
    }
    emit(state.copyWith());

  }
  void addRecord(){

    state.isExpanded.add(false);

    Matrix matrix = _formRepository.availableForms[1].fields.firstWhere((dynamic element) => element.name == 'matrix_1655016823189') as Matrix;
    var record = MatrixRecordWidget(children: matrix.values.map((e) => e.toWidget()).toList(),isLast: true,isExpanded: false,);
    matrix.records.add(MatrixRecordModel(fields: matrix.values));
    emit(state.copyWith(recordsModel: matrix.records));


  }


}




