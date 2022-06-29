import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/model/matrix/fields/MatrixCheckbox.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import 'package:provider/src/provider.dart';
import '../../form_element_widget.dart';
import '../cubit/matrix_record_cubit.dart';

class MatrixCheckboxWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
      builder: (context, state) {
        bool ? checked;
        // if(state.currentRecord != null )
        //   checked=  state.currentRecord!.fields.firstWhere((element) => element.name == this.name).value;
        //
        // else checked = this.value;
        // return CheckboxListTile(value: checked ?? value ?? false,
        return CheckboxListTile(value:  value ?? false,
            title: Text(label),
            contentPadding: EdgeInsets.only(right: 19),
            onChanged: (value) {
              context.read<MatrixRecordCubit>().fieldValueChanged(value, name);


              this.value = value;

            });
      },
    );
  }

  MatrixCheckboxWidget({
    required this.label,
    required this.name,
    required this.value
  }) : super(label: label, name: name);

  @override
  String ? valueToString() {
    return this.value != null ? this.value.toString() : this.value;
  }


  MatrixCheckbox toModel() {
    return MatrixCheckbox(name: name, label: label, value: value);
  }
}
