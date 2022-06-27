import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/FormFieldWidget.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/RecordCubit/matrix_record_cubit.dart';
import 'package:form_builder_test/data/FormRepository.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import '../IDrawable.dart';
import 'MatrixRecordWidget.dart';

class MatrixWidget extends FormElementWidget {
  MatrixWidget(
      {Key? key,
      required this.label,
      required this.visible,
      required this.required,
      required this.name,
      this.value,
      required this.records,
      required this.showIfValueSelected,
      required this.showIfFieldValue,
      required this.showIfIsRequired,
      required this.maxRecordCount,
      required this.fields})
      : super(
            label: label,
            key: key,
            name: name,
            visible: visible,
            required: required,
            showIfValueSelected: showIfValueSelected,
            showIfFieldValue: showIfFieldValue,
            showIfIsRequired: showIfIsRequired);

  final String label;
  final String name;
  final bool required;
  dynamic value;
  bool? visible;
  List<FormElementWidget> records;
  final bool showIfValueSelected;
  final String? showIfFieldValue;
  final bool? showIfIsRequired;
  final int maxRecordCount;
  final List<FormElementWidget> fields;
  var bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.read<MatrixRecordCubit>();

    return Builder(builder: (context) {
      context.read<MatrixRecordCubit>().fetchRecords(name);
      return BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
        // buildWhen: (p, c) {
        //   return p.recordsModel.length == c.recordsModel.length
        //       ? false
        //       : true;
        // },
        builder: (context, state) {

          var matrix =state.matrixList
              .firstWhere(
                  (element) => element.name == this.name);


          log('  matrix widget build');

          return FormFieldWidget(
              visible: visible,
              required: required,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 10),
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ...List.generate(
                      matrix.records.length,
                      (i) => MatrixRecordWidget(
                            children:
                                matrix.records[i]
                                .fields,
                            matrixName: this.name,
                            isFirst: state.recordsModel.length == 1,
                            index: i,
                          )),
                  IconButton(
                      onPressed: () {
                        // showRecordDialog(context);
                        context
                            .read<MatrixRecordCubit>()
                            .showNewRecordDialog(context,this, name);
                        // context.read<MatrixRecordCubit>().addRecord(name);
                      },
                      icon: Icon(
                        Icons.add_circle,
                        size: 33,
                      ))
                ],
              ));
        },
      );
    });
  }

  @override
  String valueToString() {
    return this.value.toString();
  }

  //
  // Widget setupAlertDialoadContainer(List<Widget> children) {
  //   return Container(
  //     height: 300.0, // Change as per your requirement
  //     width: 300.0, // Change as per your requirement
  //     child: Form(
  //       // key: state.key,
  //       child: Scrollbar(
  //         radius: Radius.circular(10),
  //         thickness: 1,
  //         child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: children.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Padding(
  //               padding: EdgeInsets.all(10),
  //               child: children[index],
  //
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // void showRecordDialog(BuildContext context) {
  //   // context.read<MatrixRecordCubit>().set(widget.index);
  //
  //   showDialog(
  //       useRootNavigator: false,
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return BlocProvider<MatrixRecordCubit>.value(
  //           value: bloc,
  //           child: BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
  //             builder: (context, state) {
  //
  //               return AlertDialog(
  //                 title: Text('Add'),
  //                 content: setupAlertDialoadContainer(fields),
  //                 actions: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         Expanded(
  //                           child: ElevatedButton(
  //                               style: ElevatedButton.styleFrom(
  //                                   shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(
  //                                           20))),
  //                               onPressed: () {
  //                                 context.read<MatrixRecordCubit>().addRecord(name);
  //                                 // setState(() {
  //                                 //
  //                                 // });
  //                                 Navigator.pop(context);
  //                               },
  //                               child: Text('Submit')),
  //                         ),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Expanded(
  //                           child: ElevatedButton(
  //                             style: ElevatedButton.styleFrom(
  //                                 shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(20))),
  //                             onPressed: () {
  //                               // widget.children.forEach((element) {
  //                               //   element.value = null;
  //                               // });
  //                               Navigator.pop(context);
  //                             },
  //                             child: Text('Cancel'),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               );
  //             },
  //           ),
  //         );
  //       });
  // }
}
