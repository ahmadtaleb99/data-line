import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_checkbox_model/matrix_checkbox_model.dart';

class MatrixCheckboxWidget extends StatelessWidget {


  MatrixCheckboxModel model;
  @override
  Widget build(BuildContext context) {
    return Text(model.label);
  }

  MatrixCheckboxWidget({
    required this.model,
  });
}
