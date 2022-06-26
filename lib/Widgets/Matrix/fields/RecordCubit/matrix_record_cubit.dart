import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/Matrix/MatrixRecordWidget.dart';
import 'package:form_builder_test/data/FormRepository.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/matrix_record.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/matrix_record.dart';

import 'package:meta/meta.dart';

import '../../../../dynamic form/matrix/fields/matrix_record.dart';
import '../../../../dynamic form/matrix/matrix.dart';



part 'matrix_record_state.dart';

class MatrixRecordCubit extends Cubit<MatrixRecordState> {
  MatrixRecordCubit(this._formRepository)
      : super(MatrixRecordState(
            records: [], pressedItems: [], recordsModel: []));

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

  void addRecord(String matrixName,MatrixRecordModel record) {


    List<MatrixRecordModel> list = List.from(state.recordsModel);

    var matrix = _formRepository.availableForms[1].fields.firstWhere((dynamic element) => element.name == matrixName) as Matrix;


    list.add(record);

    emit(state.copyWith(recordsModel: list));
    emit(state.copyWith(recordAdded: true));
  }
  void submit(){

    List<MatrixRecordModel> list = List.from(state.recordsModel);
    emit(state.copyWith(recordsModel: list));
  }

  void removeRecord(int index) {
    List<MatrixRecordModel> list = List.from(state.recordsModel);
    // matrix.records.add(MatrixRecordModel(fields: matrix.values));
    list.removeAt(index);
    emit(state.copyWith(recordsModel: list));
  }

  void  fieldValueChanged(dynamic value,String fieldName,int recordNumber) {
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



  Widget setupAlertDialoadContainer(MatrixRecordModel record) {

    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Form(
        // key: state.key,
        child: Scrollbar(
          radius: Radius.circular(10),
          thickness: 1,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: record.fields.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: record.fields[index].toWidget(),

              );
            },
          ),
        ),
      ),
    );
  }



  void showNewRecordDialog(BuildContext context,matrixName) {
    var matrix = _formRepository.availableForms[1].fields.firstWhere((dynamic element) => element.name == matrixName) as Matrix;
var record = MatrixRecordModel(fields: matrix.values.map((e) => e.copyWith(value: null)).toList());

    context.read<MatrixRecordCubit>().set(state.recordNumber+1);
    showDialog(
        useRootNavigator: false,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return BlocProvider<MatrixRecordCubit>.value(
            value: this,
            child: AlertDialog(
              title: Text('Add'),
              content: setupAlertDialoadContainer(record),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {

                              addRecord(matrixName,record);
                              // submit();
                            Navigator.pop(context);

                            },
                            child: Text('Submit')),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            // widget.children.forEach((element) {
                            //   element.value = null;
                            // });
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
