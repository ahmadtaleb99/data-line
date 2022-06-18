import 'package:flutter/material.dart';
import 'package:form_builder_test/dynamic%20form/matrix/fields/MatrixDatePicker.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:provider/src/provider.dart';
import '../../IDrawable.dart';
import 'package:intl/intl.dart';

class MatrixDatePickerWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue:  value != null ? DateFormat('d - MMMM - y').format(value) : '',
      readOnly: true,
      onTap: (){
      context.read<ValidationBloc>().add(MatrixDatePickerChanged(context: context,matrixDatePickerWidget: this));
      },
      decoration: InputDecoration(
        hintText: label
      ),
    );
  }

   MatrixDatePickerWidget({
    required this.label,
    required this.name,
    required this.value
   }) : super(label: label,name: name);

  @override
  String ? valueToString() {
    // TODO: implement valueToString
    return value != null ? DateFormat('d - MMMM - y').format(value) : value;
  }

  MatrixDatePicker toModel(){
    return MatrixDatePicker(name: name, label: label,value: value);
  }

}
