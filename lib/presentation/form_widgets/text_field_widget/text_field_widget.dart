import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/number_text_field_model/number_text_field_model.dart';
import 'package:form_builder_test/domain/model/text_field_model/text_field_model.dart';
import 'package:form_builder_test/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({Key? key, required this.model})
      : super(key: key);
  final TextFieldModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return FormFieldWidget(
          validator: (value) {
          }, widget: TextFormField(
          key: UniqueKey(),
          autovalidateMode  : AutovalidateMode.onUserInteraction,
          initialValue: state.valuesMap[model.name],

          onChanged: (text) {
            context.read<FormsBloc>().add(TextValueChanged(
                fieldName: model.name, value: text));
          },
        ), model: model,);
      },
    );
  }



}
