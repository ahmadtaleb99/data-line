import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_dropdown_model/matrix_dropdown_model.dart';
import 'package:form_builder_test/model/matrix/matrix.dart';

class MatrixDropDownWidget extends StatelessWidget {


  MatrixDropDownModel model;
  @override
  Widget build(BuildContext context) {
    return Text(model.label);
  }

  MatrixDropDownWidget({
    required this.model,
  });
}
