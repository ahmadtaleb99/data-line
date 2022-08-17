import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/dropdown_model/dropdown_model.dart';
import 'package:form_builder_test/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/forms/new_submission/bloc/new_form_bloc.dart';
import 'package:form_builder_test/presentation/resources/color_manager.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({Key? key, required this.dropDownModel})
      : super(key: key);
  final DropDownModel dropDownModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        log('drop widget got built ');


        return FormFieldWidget(label: this.dropDownModel.label, field:   Container(
            width: double.infinity,
            child: DecoratedBox(
                decoration: BoxDecoration(
                  color: ColorManager.primary.withOpacity(0.1),
                  borderRadius:
                  BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: ColorManager.primary,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    value: state.valuesMap[dropDownModel.name],
                      underline: Container(),
                      icon: Padding(
                        padding:
                        const EdgeInsets.only(left: 99),
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    items: dropDownModel.values
                        .map((e) =>
                        DropdownMenuItem(
                          value: e.value,
                          child: Text(e.label),
                        ))
                        .toList(),
                    onChanged: (String? newValue) {
                      context.read<FormsBloc>().add(DropDownValueChanged(
                          fieldName: dropDownModel.name, value: newValue!));
                    },
                  ),
                ))));
      },
    );
  }
}
