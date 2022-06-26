import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/RecordCubit/matrix_record_cubit.dart';

import '../../../dynamic form/IFormModel.dart';
import '../../../dynamic form/matrix/fields/MatrixTextField.dart';
import '../../IDrawable.dart';

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

        print(state.recordsModel.toString());
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
          decoration: InputDecoration(
              label: Text(label)
          ),
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
