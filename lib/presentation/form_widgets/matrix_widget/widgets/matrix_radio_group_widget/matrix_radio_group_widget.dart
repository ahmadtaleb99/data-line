import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_radio_group_model/matrix_radio_group_model.dart';

class MatrixRadioGroupWidget extends StatelessWidget {


final  MatrixRadioGroupModel model;
  @override
  Widget build(BuildContext context) {
    return Text(model.label);
  }

 const  MatrixRadioGroupWidget({
    required this.model,
  });
}
