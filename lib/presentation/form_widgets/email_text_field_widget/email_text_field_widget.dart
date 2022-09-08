import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/domain/model/email_text_field_model/email_text_field_model.dart';
import 'package:datalines/domain/model/text_area_model/text_area_model.dart';
import 'package:datalines/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';

class EmailTextFieldWidget extends StatelessWidget {
  const EmailTextFieldWidget({Key? key, required this.model})
      : super(key: key);
  final EmailTextFieldModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return FormFieldWidget(
          validator: (value) {
            return context.read<FormsBloc>().validateEmail(model);
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
