import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/Matrix/MatrixRecordWidget.dart';
import 'package:form_builder_test/data/FormRepository.dart';
import 'package:form_builder_test/dynamic%20form/FormModel.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/matrix_record.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/matrix_record.dart';

import 'package:meta/meta.dart';

import '../../../../dynamic form/matrix/fields/matrix_record.dart';
import '../../../../dynamic form/matrix/matrix.dart';


import 'package:collection/collection.dart';
part 'matrix_record_state.dart';

class MatrixRecordCubit extends Cubit<MatrixRecordState> {

  late FormModel _currentForm;
  MatrixRecordCubit(this._formRepository)
      : super(MatrixRecordState(
    matrixList: [],
           ));

  FormRepository _formRepository;




  void loadMatrices(){
    List<Matrix> matrixList = _currentForm.fields.where((element) => element is Matrix).toList().cast();
    emit(state.copyWith(matrixList: matrixList));
  }

  void setCurrentForm(String formModel){
    _currentForm= _formRepository.availableForms.firstWhere((element) => element.name == formModel);
  }
  void fetchRecords(String name) {

    List<Matrix> matrixList = List<Matrix>.from(state.matrixList);
    for(var matrix in matrixList){
      if (matrix.records.isEmpty) matrix.records.add(MatrixRecordModel(fields: matrix.values));


    }


    emit(state.copyWith(matrixList: [...matrixList]));
  }

  void addRecord(String matrixName,MatrixRecordModel record) {

    var matrixList = List<Matrix>.from(state.matrixList);

    // List<MatrixRecordModel> list = List.from(matrix.records);
                  log(record.fields[1].value.toString());


    // list.add(record);

    emit(state.copyWith(matrixList: [...state.matrixList..firstWhere((element) => element.name == matrixName).records.add(record)]));
  }


  void removeRecord(int index) {
    // List<MatrixRecordModel> list = List.from(state.recordsModel);
    // // matrix.records.add(MatrixRecordModel(fields: matrix.values));
    // list.removeAt(index);
    // emit(state.copyWith(recordsModel: list));
  }

  void  fieldValueChanged(dynamic value,String fieldName) {
    MatrixRecordModel record =   state.currentRecord!.copyWith() ;

    record.fields.firstWhere((dynamic element) => element.name == fieldName).value = value;

    emit(state.copyWith(currentRecord: record));

  }
void submited (MatrixRecordModel record,String matrixName,int index){
      Matrix matrix = (_currentForm.fields.firstWhere((element) => element.name == matrixName) as Matrix).copyWith();
    matrix.records[index]= state.currentRecord!.copyWith();

          var list = List<Matrix>.from(state.matrixList);


      emit(state.copyWith( matrixList: list));
}



 Future<DateTime?>  dateChanged(BuildContext context,fieldName) async {

   MatrixRecordModel record =   state.currentRecord!.copyWith() ;


    final date = await  showDatePicker(firstDate: DateTime(1940)
        , initialDate: DateTime(1999),
        lastDate: DateTime.now(), context: context);


  record.fields.firstWhere((dynamic element) => element.name == fieldName).value=date;


    emit(state.copyWith(currentRecord: record));
    return  date;

 }

  void _setNewCurrentRecord(MatrixRecordModel record){

    state.currentRecord = record;
    emit(state.copyWith(currentRecord: record));

  }
  void setCurrentRecord(int recordNumber,String matrixName){

    var newState = state.copyWith();
    var matrix = newState.matrixList.firstWhere((element) => element.name ==matrixName);

   MatrixRecordModel record = matrix.records[recordNumber] as MatrixRecordModel;

   state.currentRecord = record;
    emit(state.copyWith(currentRecord: record));



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
var newRecord = MatrixRecordModel(fields: matrix.values.map((e) => e.copyWith(value: null)).toList());

    _setNewCurrentRecord(newRecord);
    showDialog(
        useRootNavigator: false,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return BlocProvider<MatrixRecordCubit>.value(
            value: this,
            child: AlertDialog(
              title: Text('Add'),
              content: setupAlertDialoadContainer(newRecord),
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

                              addRecord(matrixName,state.currentRecord!);
                              submited(newRecord, matrixName, state.matrixList.length-1);
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
