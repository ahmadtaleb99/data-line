import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/number_text_field_model/number_text_field_model.dart';
import 'package:form_builder_test/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';

class NumberTextFieldWidget extends StatelessWidget {
  const NumberTextFieldWidget({Key? key, required this.numberFieldModel})
      : super(key: key);
  final NumberFieldModel numberFieldModel;

  @override
  Widget build(BuildContext context) {
    log('number widget got built ');
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        log(state.valuesMap.toString() + '   NumberTextFieldWidget');
        return FormFieldWidget(
          label: numberFieldModel.label ,
          validator: (value) {
          return context.read<FormsBloc>().validateNumber(numberFieldModel,state.valuesMap[numberFieldModel.name]);
        }, widget: TextFormField(
          key: UniqueKey(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: state.valuesMap[numberFieldModel.name],

          onChanged: (number) {
            context.read<FormsBloc>().add(FieldValueChanged(
                fieldName: numberFieldModel.name, value: number));
          },
        ), fieldModel: numberFieldModel,);
      },
    );
  }



}
