import 'package:flutter/material.dart';
import 'package:form_builder_test/FormValidation.dart';
import '../../../dynamic form/IFormModel.dart';
import '../../../dynamic form/matrix/fields/MatrixNumber.dart';
import '../../../dynamic form/matrix/fields/MatrixTextField.dart';
import '../../IDrawable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/Matrix/fields/RecordCubit/matrix_record_cubit.dart';


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
      decoration: InputDecoration(
          label: Text(label)
      ),
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
