import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/testable.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../dynamic form/DropDownItem.dart';

class DrawDropDown extends FormElement {
  final String label;
  final bool deactivate;
  final bool required;
  final bool isHidden;
  final bool multiple;
  bool? visible;
  final bool isReadOnly;
  final bool? showIfIsRequired;
  final bool showIfValueSelected;
  final String? showIfFieldValue;

  dynamic value;
  final String prompt;
  final String name;
  final String? parentName;
  final bool relatedToParent;
  final String? Function(dynamic)? validator;
  List<DropDownItem> items;

  DrawDropDown(
      {Key? key,
      required this.label,
      required this.showIfIsRequired,
      required this.deactivate,
      required this.required,
      required this.isHidden,
      required this.isReadOnly,
      required this.prompt,
       this.value,
      required this.multiple,
      required this.showIfValueSelected,
      required this.showIfFieldValue,
      this.visible = false,
      required this.items,
      required this.relatedToParent,
      this.parentName,
      required this.name,
      this.validator})
      : super(
            key: key,
            name: name,
            label: label,
            visible: visible,
            required: required,
            showIfValueSelected: showIfValueSelected,
            showIfFieldValue: showIfFieldValue,
            showIfIsRequired: showIfIsRequired);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.visible == true
          ? const EdgeInsets.only(top: 30)
          : const EdgeInsets.only(top: 0),
      child: BlocBuilder<ValidationBloc, ValidationState>(
        builder: (context, state) {
          return FormField<dynamic>(
              initialValue: value,
              validator: (value) {
                if (value == null) {
                  return 'required';
                } else
                  return null;
              },
              builder: (FormFieldState<dynamic> fieldState) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: Text(
                          label,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: double.infinity,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Center(
                                    child: DropdownButton<dynamic>(
                                        onTap: () {
                                          FocusScopeNode currentFocus =
                                              FocusScope.of(context);

                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                        },
                                        underline: Container(),
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 99),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        hint: Text(prompt),
                                        disabledHint: Text(prompt),
                                        value: value ?? null,
                                        items: _buildItems(items),
                                        onChanged: (value) {
                                          if(value == this.value) return;

                                          else context.read<ValidationBloc>().add(
                                              ParentDropListChanged(
                                                  drawDropDownButton: this,
                                                  parent: value.toString()));

                                          fieldState.didChange(value);
                                          print(value.toString() + ' eveeent ');
                                        }),
                                  )))),
                      if (fieldState.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 15),
                          child: Text(
                            fieldState.errorText!,
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 13,
                                color: Colors.red[700],
                                height: 0.5),
                          ),
                        )
                    ],
                  ));
        },
      ),
    );
  }

  List<DropdownMenuItem<dynamic>>? _buildItems(List<DropDownItem> items) {
    List<DropdownMenuItem<dynamic>>? list = [];

    print('iteemsss to draw  ${items.toString()}');
    for (var item in items) {
      list.add(DropdownMenuItem(
        child: Text(item.value),
        value: item.value,
      ));
    }
    return list;
  }

  List<MultiSelectItem<String>> _buildItemsMulti(List<DropDownItem> items) {
    List<MultiSelectItem<String>> list = [];

    print('iteemsss to draw  ${items.toString()}');
    for (var item in items) {
      list.add(MultiSelectItem(item.value, item.value));
    }
    return list;
  }

  MultiSelectDialogField<String> _buildMultiSelectDialogField() {
    return MultiSelectDialogField<String>(
      chipDisplay: MultiSelectChipDisplay.none(),
      selectedItemsTextStyle: TextStyle(color: Colors.black),
      buttonIcon: Icon(Icons.arrow_drop_down),
      decoration: BoxDecoration(),
      title: Text(label),
      buttonText: Text(prompt),
      listType: MultiSelectListType.CHIP,
      items: _buildItemsMulti(items),
      initialValue: [],
      onConfirm: (values) {
        this.value = values.first;
      },
    );
  }
}
