import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/model/matrix/fields/MatrixDatePicker.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import 'package:provider/src/provider.dart';
import '../../form_element_widget.dart';
import 'package:intl/intl.dart';

import '../cubit/matrix_record_cubit.dart';


class MatrixDatePickerWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
      builder: (context, state) {
        // var date;
        // if(value == null )
        //   date=  state.matrixList.first.records.firstWhere((element) => element.name == this.name).value;
        //
        // else date = this.value;
          return TextFormField(
            key: Key(value.toString()),
            // initialValue: value != null
            //       ? DateFormat('d - MMMM - y').format(value)
            //       : '',
            initialValue: value != null ?
            DateFormat('d - MMMM - y').format(value) : '',
            readOnly: true,
            onTap: () async {
              value = await
              context.read<MatrixRecordCubit>().dateChanged(context, name);
            },
            decoration: InputDecoration(

                hintText: label
            ),
          );
      },
    );
  }

  MatrixDatePickerWidget({
    required this.label,
    required this.name,
    required this.value
  }) : super(label: label, name: name);

  @override
  String ? valueToString() {
    // TODO: implement valueToString
    return value != null ? DateFormat('d - MMMM - y').format(value) : value;
  }

  MatrixDatePicker toModel() {
    return MatrixDatePicker(name: name, label: label, value: value);
  }

}
