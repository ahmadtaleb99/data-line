import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_checkbox_group_model/matrix_checkbox_group_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_checkbox_model/matrix_checkbox_model.dart';
import 'package:form_builder_test/model/matrix/matrix.dart';

class MatrixCheckboxGroupWidget extends StatelessWidget {


  MatrixCheckboxGroupModel model;
  @override
  Widget build(BuildContext context) {
    return Text(model.label);
  }

  MatrixCheckboxGroupWidget({
    required this.model,
  });
}
