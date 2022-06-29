import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/model/CheckboxItem.dart';
import 'package:form_builder_test/model/IFormModel.dart';
import 'package:form_builder_test/model/matrix/fields/MatrixTextField.dart';

import '../../form_element_widget.dart';

import 'package:flutter/material.dart';

import '../cubit/matrix_record_cubit.dart';

class MatrixCheckboxGroupWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;
  final List<CheckboxItem> children;

  @override
  Widget build(BuildContext context) {

    log(this.value.toString());
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
                  CheckboxListTile(contentPadding: EdgeInsets.only(right: 15), onChanged: (checked) {
                    this.value = context.read<MatrixRecordCubit>().checkboxGroupValueChanged(checked!, name,e.value);

                  }, value:  this.value.contains(e.value), title: Text(e.label),))
            ]);
      },
    );
  }

  MatrixCheckboxGroupWidget({
    required this.label,
    required this.name,
    required this.value,
    required this.children
  }) : super(label: label, name: name);

  @override
  String ? valueToString() {
    return this.value != null  ? value.join(', ').toString() : this.value;
  }


}
