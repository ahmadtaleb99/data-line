import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/dropdown_model/dropdown_model.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/forms/new_submission/bloc/new_form_bloc.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({Key? key, required this.dropDownModel})
      : super(key: key);
  final DropDownModel dropDownModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        log(state.submissionMap[dropDownModel.name].toString());

        return DropdownButton<String>(
          value: state.submissionMap[dropDownModel.name],
          items: dropDownModel.values
              .map((e) =>
              DropdownMenuItem(
                value: e.value,
                child: Text(e.label),
              ))
              .toList(),
          onChanged: (String? newValue) {
            context.read<FormsBloc>().add(FieldValueChanged(
                fieldName: dropDownModel.name, value: newValue!));
          },
        );
      },
    );
  }
}
