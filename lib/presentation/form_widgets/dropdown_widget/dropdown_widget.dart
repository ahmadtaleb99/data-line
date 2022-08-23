import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/dropdown_model/dropdown_model.dart';
import 'package:form_builder_test/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/forms/new_submission/bloc/new_form_bloc.dart';
import 'package:form_builder_test/presentation/resources/color_manager.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

import '../../../domain/model/dropdown_item_model/dropdown_item_model.dart';
import '../../../domain/model/form_model.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({Key? key, required this.dropDownModel})
      : super(key: key);
  final DropDownModel dropDownModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {

        return FormFieldWidget(

          widget: Container(
              width: double.infinity,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: ColorManager.primary,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: DropdownButton<String>(
                      hint:Text( dropDownModel.prompt),
                      value: state.valuesMap[dropDownModel.name],
                        // isExpanded: true,
                      underline: Container(),
                      icon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Icon(Icons.arrow_drop_down),
                      ),
                      // items: hasItems()? [DropdownMenuItem<String>(child: Container(),)] :
                      items:
                      dropDownModel.values.map((e) => DropdownMenuItem(
                                value: e.value,
                                child: Text(e.label),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        // if(!hasItems()) return;
                         context.read<FormsBloc>().add(DropDownValueChanged(
                            fieldName: dropDownModel.name, value: newValue!));
                      },
                    ),
                  ))),
          fieldModel: dropDownModel,
        );
      },
    );
  }

  bool hasItems(){
    return dropDownModel.values.isEmpty;
  }
}
