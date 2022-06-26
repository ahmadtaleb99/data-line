import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/MatrixDatePicker.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:provider/src/provider.dart';
import '../../IDrawable.dart';
import 'package:intl/intl.dart';

import 'RecordCubit/matrix_record_cubit.dart';

class MatrixDatePickerWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MatrixRecordCubit, MatrixRecordState, DateTime?>(
      selector: (state) => state.dateTime ,

      builder: (context, state) {
        return TextFormField(
          key: Key(state.toString()),
          // initialValue: value != null
          //       ? DateFormat('d - MMMM - y').format(value)
          //       : '',
          initialValue: state != null ?
          DateFormat('d - MMMM - y').format(state) : '',
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
