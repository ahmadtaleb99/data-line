import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/Matrix/matrix_record_widget.dart';
import 'package:form_builder_test/data/FormRepository.dart';
import 'package:form_builder_test/model/FormModel.dart';
import 'package:form_builder_test/model/matrix/fields/matrix_record.dart';
import 'package:form_builder_test/model/matrix/fields/matrix_record.dart';

import 'package:meta/meta.dart';

import '../../../../model/matrix/fields/matrix_record.dart';
import '../../../../model/matrix/matrix.dart';


import 'package:collection/collection.dart';
part 'matrix_record_state.dart';

class MatrixRecordCubit extends Cubit<MatrixRecordState> {

  late FormModel _currentForm;
  MatrixRecordCubit(this._formRepository)
      : super(MatrixRecordState(
    errorText: '',
    matrixList: [],index: 0
           ));

  FormRepository _formRepository;
  List _oldValues = [ ] ;

    @override
  Future<void> close() async {
    // TODO: implement close
     super.close();
    log('cubit closed');
  }


  void loadMatrices(){
    List<Matrix> matrixList = _currentForm.fields.where((element) => element is Matrix).toList().cast();
    emit(state.copyWith(matrixList: matrixList));

  }
  void setCurrentSubmittedForm(int index){
      _currentForm = _formRepository.submittedForms[index].copyWith();
  }
  void setCurrentForm(int index){
    _currentForm = _formRepository.availableForms[index].copyWith();
    List<Matrix> matrixList = _currentForm.fields.where((element) => element is Matrix).toList().cast();
  }

  void fetchRecords(String name) {

    List<Matrix> matrixList = List<Matrix>.from(state.matrixList);
    emit(state.copyWith(matrixList: [...matrixList]));
  }

  void addRecord(String matrixName,MatrixRecordModel record) {
    emit(state.copyWith(matrixList: [...state.matrixList..firstWhere((element) => element.name == matrixName).records.add(record)]));
  }


  void removeRecord(String matrixName,MatrixRecordModel record) {

              var matrix = state.matrixList.firstWhere((element) => element.name == matrixName);
              matrix.records.remove(record);
              if(matrix.records.length <= matrix.maxRecordsCount){
                matrix.error = '';
              }
    emit(state.copyWith(matrixList: state.matrixList));

  }

  void  fieldValueChanged(dynamic value,String fieldName) {
    MatrixRecordModel record =   state.currentRecord! ;
    record.fields.firstWhere((dynamic element) => element.name == fieldName).value = value;

    var list = List<Matrix>.from(state.matrixList);
    list.first.records[state.index] = record;

    emit(state.copyWith(matrixList: list,currentRecord: record));

  }

     checkboxGroupValueChanged(bool checked,String fieldName,String boxValue) {
    MatrixRecordModel record =   state.currentRecord! ;
    var field =  record.fields.firstWhere((dynamic element) => element.name == fieldName);
    if(checked == true )
    field.value = List.from(field.value)..add(boxValue);
    else
      field.value = List.from(field.value)..remove(boxValue);



    var list = List<Matrix>.from(state.matrixList);
    list.first.records[state.index] = record;

    emit(state.copyWith(matrixList: list,currentRecord: record));
    return field.value;
  }


  void formSubmited (){
      _currentForm = _formRepository.availableForms.firstWhere((element) => element.name ==_currentForm.name);
    List<Matrix> matrixList = _currentForm.fields.where((element) => element is Matrix).toList().cast();
    emit(state.copyWith(matrixList: matrixList));
  }



  void  showRecordClosed() {
    MatrixRecordModel record =   state.currentRecord!.copyWith() ;

        for(int i =0 ; i<record.fields.length ; i++){
          record.fields[i].value = _oldValues[i];
        }


    var list = List<Matrix>.from(state.matrixList);
    list.first.records[state.index] = record;


    emit(state.copyWith(matrixList: list,currentRecord: record));

  }


 Future<DateTime?>  dateChanged(BuildContext context,fieldName) async {

   MatrixRecordModel record =   state.currentRecord!.copyWith() ;


    final date = await  showDatePicker(firstDate: DateTime(1940)
        , initialDate: DateTime(1999),
        lastDate: DateTime.now(), context: context);
    if(date == null ) return date;
  record.fields.firstWhere((dynamic element) => element.name == fieldName).value=date;


   var list = List<Matrix>.from(state.matrixList);
   list.first.records[state.index] = record;


    emit(state.copyWith(matrixList: list  ,currentRecord: record));
    return  date;

 }

  void _setNewCurrentRecord(MatrixRecordModel record,String matrixName){

    int index = state.matrixList.firstWhere((element) => element.name == matrixName).records.length-1;
    emit(state.copyWith(currentRecord: record,index: index));

  }
  void setCurrentRecord(int recordNumber,String matrixName){


    var newState = state.copyWith();
    var matrix = newState.matrixList.firstWhere((element) => element.name ==matrixName);

   MatrixRecordModel record = matrix.records[recordNumber] as MatrixRecordModel;
    _oldValues = [ ];
    record.fields.forEach((element) { _oldValues.add(element.value);});

   state.currentRecord = record;
    emit(state.copyWith(currentRecord: record,index: recordNumber));



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

    var matrix = _currentForm.fields.firstWhere((dynamic element) => element.name == matrixName) as Matrix;
    if(matrix.records.length == matrix.maxRecordsCount){
      matrix.error = 'Maximum number of records is ${matrix.maxRecordsCount}';
        emit(state.copyWith())      ;
        return;
    }
var newRecord = MatrixRecordModel(fields: matrix.values.map((e) => e.copyWith(value: null)).toList());
    addRecord(matrixName, newRecord);
    _setNewCurrentRecord(newRecord,matrixName);
    showDialog(
        useRootNavigator: false,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              removeRecord(matrixName, state.currentRecord!);
              return true;
            },
            child: BlocProvider<MatrixRecordCubit>.value(
              value: this,
              child: BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
  builder: (context, state) {
    return AlertDialog(
                title: Text('Add new record'),
                content: setupAlertDialoadContainer(state.currentRecord!),
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

                                if (state.currentRecord!.isEmpty()) {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error,
                                      title: 'Can\'t add Record',
                                      text: 'One field must have a value at least');
                                  return;
                                }

                                if(state.currentRecord!.fields.last.isValid())
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
                              removeRecord(matrixName, state.currentRecord!);
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
  },
),
            ),
          );
        });
  }
}
