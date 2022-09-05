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
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return FormFieldWidget(
          validator: (number) {

            return context.read<FormsBloc>().validateNumber('',numberFieldModel);

          }, widget: TextFormField(

          key: UniqueKey(),
         validator: (number){
           // return  context.read<FormsBloc>().validateNumber(number!,numberFieldModel);
         },
          onChanged: (number) {
              context.read<FormsBloc>().add(TextValueChanged(
                  fieldName: numberFieldModel.name, value: number));
          },

          autovalidateMode  : requireValidation(state)   ?  AutovalidateMode.always : AutovalidateMode.onUserInteraction,
          initialValue: state.valuesMap[numberFieldModel.name],



        ), model: numberFieldModel,);
      },
    );
  }


    bool requireValidation(FormsState state){
    return state.validationMap[numberFieldModel.name] != null &&state.validationMap[numberFieldModel.name] == true;
    }
}
