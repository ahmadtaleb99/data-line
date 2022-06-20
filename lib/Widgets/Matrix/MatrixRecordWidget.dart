import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/RecordCubit/matrix_record_cubit.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/MatrixRadioGroup.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/matrix_record.dart';
import 'package:collection/collection.dart';

import '../../dynamic form/IFormModel.dart';
import '../../logic/validation__bloc.dart';
import '../IDrawable.dart';

class MatrixRecordWidget extends FormElementWidget {

  MatrixRecordWidget({Key? key, this.isLast = true,
    required this.children,
     this.index,
    this.isExpanded = false
  })
      : super(key: key, name: 'sad', label: '');
  final bool isLast;
  final List<FormElementWidget> children;
   bool isExpanded;
   final int ?  index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
      builder: (context, state) {
          log('build');

        return Container(


          child: Row(
            children: [
              Expanded(
                flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0, top: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onTap: () {

                          // showRecordDialog(context, state.key);
                        },
                        child: Column(
                          children: [


                            ...List<Widget>.generate( state.isExpanded[index!] ? children.length : 1 , (index) {
                              return  Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(child: Text(children[index].label)),
                                    Expanded(child: Text(children[index].valueToString() ?? '',overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)),
                                  ],
                                ),
                              );
                            })
                            ,


                          ],
                        ),
                      ),
                    ),
                  )),
              // if (isLast)
                Expanded(

                  child: IconButton(
                      onPressed: () {
                        context.read<MatrixRecordCubit>().addRecord();
                      },
                      icon: Icon(Icons.add_circle)),
                ),
              // else
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        context.read<ValidationBloc>().add(RecordRemoved(
                            matrixName: 'matrix_1655016823189',
                            matrixRecord: this));
                      },
                      icon: Icon(Icons.remove)),
                ),
              IconButton(
                  onPressed: () {
                      log('buton');
                    log(state.isExpanded[index!].toString());
                  context.read<MatrixRecordCubit>().toggleExpanded(this,index!);
                  },
                   icon : Icon(  state.isExpanded[index!] ?   Icons.arrow_drop_up : Icons.arrow_drop_down)) ,

            ],
          ),
        );
      },
    );
  }

  @override
  String valueToString() {
    return this.value;
  }

  MatrixRecordModel toModel() {
    return MatrixRecordModel(
        fields: this.children.map((dynamic e) => e.toModel()).toList().cast());
  }
  Widget setupAlertDialoadContainer(List children) {

    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: Form(
            key: state.key,
            child: Scrollbar(
              radius: Radius.circular(10),
              thickness: 1,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: children.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: children[index],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void showRecordDialog(BuildContext context, GlobalKey<FormState> key) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async{

              this.children.forEach((element) {
                element.value = null;
              });

              context.read<ValidationBloc>().add(Refresher());
                return true;
            },
            child: AlertDialog(
              title: Text('Add'),
              content: setupAlertDialoadContainer(children),
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

                              context.read<ValidationBloc>().add(MatrixSubmitted(matrixName: this.name,context: context));

                            },
                            child: Text('submit')),
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
                            this.children.forEach((element) {
                              element.value = null;
                            });
                            Navigator.pop(context);
                          },
                          child: Text('clear'),
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

  MatrixRecordWidget copyWith({
    bool? isLast,
    List<FormElementWidget>? children,
    bool? isExpanded,
  }) {
    return MatrixRecordWidget(
      isLast: isLast ?? this.isLast,
      children: children ?? this.children,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}



