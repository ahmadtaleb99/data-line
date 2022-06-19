import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/Widgets/Matrix/MatrixRecordWidget.dart';
import 'package:form_builder_test/data/FormRepository.dart';
import 'package:meta/meta.dart';

import '../../../../dynamic form/matrix/matrix.dart';

part 'matrix_record_state.dart';

class MatrixRecordCubit extends Cubit<MatrixRecordState> {
  MatrixRecordCubit(this._formRepository) : super(MatrixRecordState(records: [],pressedItems: []));

    FormRepository _formRepository;


  void toggleExpanded(MatrixRecordWidget matrixRecordWidget){


    List<MatrixRecordWidget> list = List.from(state.pressedItems);

    print( state.pressedItems.contains(matrixRecordWidget) );
    list.contains(matrixRecordWidget) ?
    list.remove(matrixRecordWidget)
        : list.add(matrixRecordWidget);


    emit(state.copyWith(pressedItems: list));
  }
  
  void addRecord(){
    Matrix matrix = _formRepository.availableForms[1].fields.firstWhere((dynamic element) => element.name == 'matrix_1655016823189') as Matrix;
    var record = MatrixRecordWidget(children: matrix.values.map((e) => e.toWidget()).toList(),isLast: true,isExpanded: false,);

    emit(state.copyWith(records:  List.from(state.records)..add(record)));


  }


}




