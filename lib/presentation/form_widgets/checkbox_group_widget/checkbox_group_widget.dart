import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/domain/model/checkbox_group_item_model/checkbox_group_item_model.dart';
import 'package:datalines/domain/model/checkbox_group_model/checkbox_group_model.dart';
import 'package:datalines/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';

class CheckboxGroupWidget extends StatelessWidget {
  final CheckboxGroupModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return FormFieldWidget<List>(
          validator: (value){
            return context.read<FormsBloc>().validateCheckboxGroup(model);
          },
            model: model,
            widget: Column(
              children: model.values
                  .map((CheckboxGroupItemModel e) => CheckboxListTile(
                        value: getValue(state, e.value),
                        onChanged: (isChecked) {

                          context.read<FormsBloc>().add(
                              CheckboxGroupValueChanged(
                                  fieldName: model.name,
                                  isChecked: isChecked!,
                                  value: e.value));

                        },
                        title: Text(e.label),
                      ))
                  .toList(),
            ));
      },
    );
  }

    bool getValue(FormsState state, String value) {
      List? list = state.valuesMap[model.name];
      if (list == null) return false;
      return list.contains(value) ? true : false;
    }

  const CheckboxGroupWidget({
    required this.model,
  });
}
