import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_checkbox_model/matrix_checkbox_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_date_picker_model/matrix_date_picker_model.dart';

class MatrixDatePickerWidget extends StatelessWidget {


  MatrixDatePickerModel model;
  @override
  Widget build(BuildContext context) {
    return Text(model.label);
  }

  MatrixDatePickerWidget({
    required this.model,
  });
}
