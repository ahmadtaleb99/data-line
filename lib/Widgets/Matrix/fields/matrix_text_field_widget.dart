import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/matrix_record_cubit.dart';

import '../../../utils/constants.dart';
import '../../../model/IFormModel.dart';
import '../../../model/matrix/fields/MatrixTextField.dart';
import '../../form_element_widget.dart';

class MatrixTextFieldWidget extends FormElementWidget {

  IFormModel toModel() {
    return MatrixTextField(name: name, label: label, value: value);
  }

  final String label;
  final String name;
  dynamic value;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
      builder: (context, state) {

        return TextFormField(
            // initialValue:  state.recordsModel[state.recordNumber].fields.firstWhere((dynamic element) => element.name == this.name).value,
          initialValue:  value,
          onChanged: (value) {
            context.read<MatrixRecordCubit>().fieldValueChanged(value,name);
            this.value = value;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return null;
          },
          decoration: kTextFieldDecoration(label),
        );

      },
    );
  }

  MatrixTextFieldWidget({
    required this.label,
    required this.name,
    required this.value
  }) : super(label: label, name: name);

  @override
  String ? valueToString() {
    return this.value;
  }

  MatrixTextFieldWidget copyWith({
    String? label,
    String? name,
    dynamic? value,
  }) {
    return MatrixTextFieldWidget(
      label: label ?? this.label,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }
}
