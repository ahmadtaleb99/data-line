import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_checkbox_model/matrix_checkbox_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_date_picker_model/matrix_date_picker_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_text_field_model/matrix_text_field_model.dart';
import 'package:form_builder_test/model/matrix/matrix.dart';

class MatrixTextFieldWidget extends StatelessWidget {


  MatrixTextFieldModel model;
  @override
  Widget build(BuildContext context) {
    return Text(model.label);
  }

  MatrixTextFieldWidget({
    required this.model,
  });
}
