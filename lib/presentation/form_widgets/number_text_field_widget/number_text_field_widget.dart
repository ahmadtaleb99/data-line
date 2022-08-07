import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/number_text_field_model/number_text_field_model.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';

class NumberTextFieldWidget extends StatelessWidget {
  const NumberTextFieldWidget({Key? key, required this.numberFieldModel}) : super(key: key);
    final NumberFieldModel numberFieldModel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (number) {
        FieldValueChanged(
            fieldName: numberFieldModel.name, value: number);
      },
    );
  }
}
