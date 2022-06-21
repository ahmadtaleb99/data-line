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
  MatrixWidget({Key? key,
    required this.label,
    required this.visible,
    required this.required,
    required this.name,
    this.value,
    // required   this.records,
    required this.showIfValueSelected,
    required this.showIfFieldValue,
    required this.showIfIsRequired,
    required this.maxRecordCount,
    required this.records,
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

  final bool showIfValueSelected;
  final String? showIfFieldValue;
  final bool? showIfIsRequired;
  final int maxRecordCount;
  final List<FormElementWidget> fields;

  List<MatrixRecordWidget> records = [];

  @override
  Widget build(BuildContext context) {
    log(this.value.toString() + ' the value of matrix widget');

    return Builder(
      builder: (context) {
        context.read<MatrixRecordCubit>().fetchRecords(name);
        return BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
          builder: (context, state) {
            return FormFieldWidget(
                visible: visible,
                required: required,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        state.recordsModel.length,
                            (i) =>
                            MatrixRecordWidget(
                              children: state.recordsModel[i].fields
                                 ,
                                    matrixName: this.name,
                              isLast: i == state.recordsModel.length - 1,
                              index: i,
                            )),
                  ],
                ));
          },
        );
      }
    );
  }


  @override
  String valueToString() {
    return this.value.toString();
  }
}
