import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/form_field_widget.dart';
import 'package:form_builder_test/data/FormRepository.dart';
import 'package:form_builder_test/model/IFormModel.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import '../form_element_widget.dart';
import 'matrix_record_widget.dart';
import 'cubit/matrix_record_cubit.dart';

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
  var list;
  final List<FormElementWidget> fields;
  var bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.read<MatrixRecordCubit>();

    return BlocListener<ValidationBloc, ValidationState>(
      listener: (context, state) {
        if (state.submitted! && state.status == Status.success) {
          context.read<MatrixRecordCubit>().formSubmited();
        }
      },
      child: Builder(builder: (context) {
        context.read<MatrixRecordCubit>().fetchRecords(name);
        return BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
          builder: (context, state) {
            var matrix = state.matrixList
                .firstWhere((element) => element.name == this.name);

            list = matrix.records.map((e) => e.copyWith());

            return khF(
                visible: visible,
                // required: required,

                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ...List.generate(
                        matrix.records.length,
                        (i) => MatrixRecordWidget(
                              children: matrix.records[i].fields,
                              matrixName: this.name,
                              isFirst: true,
                              index: i,
                            )),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              primary: Colors.black),
                          onPressed: () {
                              context
                                  .read<MatrixRecordCubit>()
                                  .showNewRecordDialog(context, this.name);

                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Add Record',
                              ),
                              Icon(Icons.add, color: Colors.white)
                            ],
                          )),


                    ),
                    if(matrix.error.isNotEmpty)
                    Padding(
                        padding: const EdgeInsets.only(left: 8, top: 10),
                        child: Text(
                          matrix.error,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 13,
                              color: Colors.red[700],
                              height: 0.5),
                        ))
                  ],
                ));
          },
        );
      }),
    );
  }

  @override
  String valueToString() {
    return this.value.toString();
  }
}
