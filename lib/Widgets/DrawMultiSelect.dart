import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'DrawChildList.dart';
import '../dynamic form/DropDownItem.dart';

class DrawMultiSelect extends FormElement {
  DrawMultiSelect(
      {Key? key,
      this.visible = false,
      required this.label,
      required this.showIfIsRequired,
      required this.deactivate,
      required this.required,
      required this.relatedToParent,
      required this.isHidden,
      required this.isReadOnly,
      required this.prompt,
      required this.items,
      required this.multiple,
      this.selectedValues = const [],
      required this.showIfValueSelected,
      required this.showIfFieldValue,
      this.parentName,
      required this.name,
      this.validator})
      : super(
            key: key,
            label: label,
            name: name,
            visible: visible,
            required: required,
            showIfValueSelected: showIfValueSelected,
            showIfFieldValue: showIfFieldValue,
            showIfIsRequired: showIfIsRequired);

  dynamic value;
  final String label;
  final bool deactivate;
  final bool required;
  final bool isHidden;
  final bool multiple;
  bool? visible;
  List<String> selectedValues;
  final bool isReadOnly;
  final bool relatedToParent;
  final bool? showIfIsRequired;
  final bool showIfValueSelected;
  final String? showIfFieldValue;

  final String prompt;
  final String name;
  final String? parentName;
  final String? Function(dynamic)? validator;

  List<DropDownItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.visible == true
          ? const EdgeInsets.only(top: 30)
          : const EdgeInsets.only(top: 0),
      child: BlocBuilder<ValidationBloc, ValidationState>(
        builder: (context, state) {
          print('2 ${this.parentName}');

          DrawMultiSelect? list;
          List<DropDownItem> itemsToBuild;
          var parentList;
          String parentListLabel = 'nu';

          if (!relatedToParent) {
            itemsToBuild = this.items;
          } else {
            parentList = state.form!.fields
                .firstWhereOrNull((element) => element.name == this.parentName);
            parentListLabel = parentList.label;
            print('fat2 $name');
            if (state.childsMap != null &&
                state.childsMap.isNotEmpty &&
                state.childsMap[this.name] != null) {
              list = state.childsMap[this.name] as DrawMultiSelect;
              itemsToBuild = list.items;
            } else {
              list = null;
              itemsToBuild = [];
            }
          }

          return FormField<dynamic>(
              validator: (value) {
                if (this.selectedValues.isEmpty)
                  return 'required';
                else
                  return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              builder: (FormFieldState<dynamic> fieldState) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: Text(
                          '$label  ${itemsToBuild.isEmpty ? ' - ${parentListLabel}' : itemsToBuild.first.parent} ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Center(
                            child: MultiSelectDialogField<String>(
                              searchable: true,
                              decoration: BoxDecoration(

                                color: Colors.blue.withOpacity(0.1),
                                borderRadius:
                                BorderRadius.all(Radius.circular(40)),
                              ),
                              chipDisplay: MultiSelectChipDisplay(

                                alignment: Alignment.topCenter,
                                onTap: (value) {
                                  context.read<ValidationBloc>().add(
                                      MultiSelectItemRemoved(
                                          item: value,
                                          select: this,
                                          selectName: this.name));
                                  print(value);
                                },
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              dialogHeight: items.isEmpty ? 5 : null,
                              dialogWidth: items.isEmpty ? 5 : null,
                              selectedItemsTextStyle:
                                  TextStyle(color: Colors.black),
                              buttonIcon: Icon(Icons.arrow_drop_down),

                              title: items.isEmpty
                                  ? Text('Please Select a $parentListLabel')
                                  : Text(label),
                              buttonText: Text(prompt),
                              listType: MultiSelectListType.CHIP,

                              // items: relatedToParent && items.isEmpty ?  _buildItemsMulti([]) :  _buildItemsMulti(items!) ,
                              items: _buildItemsMulti(items),
                              initialValue: list?.selectedValues ?? null,
                              onConfirm: (values) {
                                fieldState.didChange(values);
                                selectedValues = values;
                                if (items.isNotEmpty && relatedToParent)
                                  context.read<ValidationBloc>().add(
                                      childDropDownChanged(
                                          childList: this, value: ''));
                              },
                            )),
                      ),
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

  List<MultiSelectItem<String>> _buildItemsMulti(
      List<DropDownItem> items) {
    List<MultiSelectItem<String>> list = [];
    if (items.isEmpty) {
      return [];
    }
    print('iteemsss to draw  ${items.toString()}');
    for (var item in items) {
      list.add(MultiSelectItem(item.value, item.value));
    }
    return list;
  }

  DrawMultiSelect copyWith({
    String? value,
    String? label,
    bool? deactivated,
    bool? required,
    bool? isHidden,
    bool? multiple,
    bool? visible,
    bool? isReadOnly,
    bool? relatedToParent,
    bool? showIfIsRequired,
    bool? showIfValueSelected,
    String? showIfFieldValue,
    String? prompt,
    String? name,
    String? parentName,
    String? Function(dynamic)? validator,
    List<DropDownItem>? items,
    List<MultiSelectItem<String>>? list,
  }) {
    return DrawMultiSelect(
      label: label ?? this.label,
      deactivate: deactivated ?? this.deactivate,
      required: required ?? this.required,
      isHidden: isHidden ?? this.isHidden,
      multiple: multiple ?? this.multiple,
      visible: visible ?? this.visible,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      relatedToParent: relatedToParent ?? this.relatedToParent,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      showIfValueSelected: showIfValueSelected ?? this.showIfValueSelected,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      prompt: prompt ?? this.prompt,
      name: name ?? this.name,
      parentName: parentName ?? this.parentName,
      validator: validator ?? this.validator,
      items: items ?? this.items,
    );
  }
}
