import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/app/utils/debouncer.dart';
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
        return FormFieldWidget(
          validator: (number) {
            return context.read<FormsBloc>().validateNumber(numberFieldModel);

          }, widget: TextFormField(
          key: UniqueKey(),
         validator: (number){
            if(state.validationMap[numberFieldModel.name] == true ) return null; else return ' f';
         },
          onChanged: (number) {
              context.read<FormsBloc>().add(FieldValueChanged(
                  fieldName: numberFieldModel.name, value: number));
          },

          autovalidateMode  : AutovalidateMode.onUserInteraction,
          initialValue: state.valuesMap[numberFieldModel.name],



        ), fieldModel: numberFieldModel,);
      },
    );
  }



}
