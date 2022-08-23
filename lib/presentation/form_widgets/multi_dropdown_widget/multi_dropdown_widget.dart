import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/dropdown_model/dropdown_model.dart';
import 'package:form_builder_test/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/forms/new_submission/bloc/new_form_bloc.dart';
import 'package:form_builder_test/presentation/resources/color_manager.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../../domain/model/dropdown_item_model/dropdown_item_model.dart';
import '../../../domain/model/form_model.dart';

class MultiDropDownWidget extends StatelessWidget {
  const MultiDropDownWidget({Key? key, required this.dropDownModel})
      : super(key: key);
  final DropDownModel dropDownModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        // List<String>? items = state.valuesMap[dropDownModel.name];
        return FormFieldWidget(
          validator: (value){
            return context.read<FormsBloc>().validateDropDown(dropDownModel);
          },
          widget: Container(
              width: double.infinity,
              child: Center(
                child: MultiSelectDialogField<String>(
                  selectedItemsTextStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  barrierColor: Colors.grey.withOpacity(0.2),
                  key: GlobalKey(),
                  searchable: true,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: ColorManager.primary,
                      width: 2,
                    ),
                  ),
                  chipDisplay: MultiSelectChipDisplay(
                    textStyle: TextStyle(
                        color: ColorManager.black, fontWeight: FontWeight.bold),
                    alignment: Alignment.topCenter,
                    onTap: (item) {
                      context.read<FormsBloc>().add(MultiDropDownValueTapped(
                          fieldName: dropDownModel.name, value: item));
                    },
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  dialogHeight: dropDownModel.values.isEmpty ? 5 : null,
                  dialogWidth: dropDownModel.values.isEmpty ? 5 : null,
                  buttonIcon: Icon(Icons.arrow_drop_down),
                  title: Text('Please Select a value'),
                  buttonText: Text(dropDownModel.prompt),
                  listType: MultiSelectListType.CHIP,
                  items: dropDownModel.values
                      .map((e) => MultiSelectItem<String>(e.value, e.label))
                      .toList()
                      .cast(),
                  initialValue: state.valuesMap[dropDownModel.name],
                  onConfirm: (values) {
                    context.read<FormsBloc>().add(FieldValueChanged(
                        fieldName: dropDownModel.name, value: values));
                  },
                ),
              )),
          fieldModel: dropDownModel,
        );
      },
    );
  }

  bool hasItems() {
    return dropDownModel.values.isEmpty;
  }
}