import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/model/RadioItem.dart';
import 'package:form_builder_test/model/matrix/fields/MatrixRadioGroup.dart';

import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import '../../form_element_widget.dart';
import '../cubit/matrix_record_cubit.dart';

class MatrixRadioGroupWidget extends FormElementWidget {
  final String label;
  final String name;
  final List<RadioItem> children;
  dynamic value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
      builder: (context, state) {
        return  Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 10, top: 10),
                child: Text(
                  // '$label  ${itemsToBuild.isEmpty ? ' - ${parentListLabel}' : itemsToBuild.first.parent} '
                  '$label'
                  , style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ...children.map((e) =>
                  RadioListTile<String>(groupValue: value,contentPadding: EdgeInsets.only(right: 15), onChanged: (value) {
                    context.read<MatrixRecordCubit>().fieldValueChanged(value, name);

                    this.value = value;
                  }, value: e.value, title: Text(e.value),))
            ]);

      },
    );
  }

  MatrixRadioGroupWidget({
    required this.label,
    required this.name,
    required this.children,
    required this.value
  }) : super(label: label, name: name);

  @override
  String ? valueToString() {

    return this.value;

  }

  MatrixRadioGroup toModel() {
    return MatrixRadioGroup(
        name: name, label: label, values: children, value: value);
  }

}
