import 'package:flutter/material.dart';
import 'package:form_builder_test/utils/feild_validation_mixin.dart';
import '../../../utils/constants.dart';
import '../../../model/IFormModel.dart';
import '../../../model/matrix/fields/MatrixNumber.dart';
import '../../../model/matrix/fields/MatrixTextField.dart';
import '../../form_element_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/matrix_record_cubit.dart';


class MatrixNumberWidget extends FormElementWidget with FormValidation {
  final String label;
  final String name;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue:  value,
      onChanged: (value) {
        context.read<MatrixRecordCubit>().fieldValueChanged(value,name);
        this.value = value;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction  ,
      validator: (value) {
           if(!isNumeric(value!) && value.isNotEmpty) return 'Must be a number';


      },
      decoration: kTextFieldDecoration(label),
    );
  }



   MatrixNumberWidget({
    required this.label,
    required this.name,
    required this.value
   }) : super(label: label,name: name);

  @override
  String ? valueToString() {

    return this.value;

  }

  MatrixNumberWidget copyWith({
    String? label,
    String? name,
    dynamic? value,
  }) {
    return MatrixNumberWidget(
      label: label ?? this.label,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }


  IFormModel toModel(){
    return MatrixNumber(name: name, label: label,value: value);
  }


}
