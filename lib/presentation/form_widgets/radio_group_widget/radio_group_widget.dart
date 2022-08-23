import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/radio_group_item_model/radio_group_item_model.dart';
import 'package:form_builder_test/domain/model/radio_group_model/radio_group_model.dart';
import 'package:form_builder_test/presentation/form_widgets/form_field_widget/form_field_widget.dart';

import '../../../Widgets/form_field_widget.dart';
import '../../forms/bloc/forms_bloc.dart';

class RadioGroupWidget extends StatelessWidget {
  const RadioGroupWidget({Key? key, required this.model}) : super(key: key);

  final RadioGroupModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return FormFieldWidget<List>(
            validator: (value){
            },
            fieldModel: model,
            widget: Column(
              children: model.values
                  .map((RadioGroupItemModel e) => RadioListTile (
                value:false,

                onChanged: (isChecked) {

                  // context.read<FormsBloc>().add(
                  //     CheckboxGroupValueChanged(
                  //         fieldName: model.name,
                  //         isChecked: isChecked!,
                  //         value: e.value));

                },
                title: Text(e.label), groupValue:  ,
              ))
                  .toList(),
            ));
      },
    );
  }

  bool getValue(FormsState state, String value) {
    List? list = state.valuesMap[model.name];
    if (list == null) return false;
    return false;
  }
}
