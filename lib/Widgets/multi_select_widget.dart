import 'package:collection/src/iterable_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/form_element_widget.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'child_dropdown_widget.dart';
import '../model/DropDownItem.dart';

class MultiSelectWidget  extends FormElementWidget {

  MultiSelectWidget(
      {Key? key,
      this.visible = false,
      required this.label,
      required this.showIfIsRequired,
      required this.deactivate,
      this.value,
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
  List<String>? selectedValues;
  final bool isReadOnly;
  final bool relatedToParent;
  final bool? showIfIsRequired;
  final bool showIfValueSelected;
  final String? showIfFieldValue;
  final String prompt;
  final String name;
  final String? parentName;
  final String? Function(dynamic)? validator;
  List<String>? l = [
    'Eating',
    'Politics',
  ];
  List<DropDownItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: this.visible == true
            ? const EdgeInsets.only(top: 30)
            : const EdgeInsets.only(top: 0),
        child: BlocBuilder<ValidationBloc, ValidationState>(
          buildWhen: (context, state) {
            if (1 == 1)
              return true;
            else
              return false;
          },
          builder: (context, state) {
            String parentLabel ='';

            if(relatedToParent)
             parentLabel = state.form!.fields.firstWhere((element) => element.name == parentName).label;


            return FormField<dynamic>(
                initialValue: selectedValues,
                validator: (value) {
                  if (value.isEmpty)
                    return 'required';
                  else
                    return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                builder: (FormFieldState<dynamic> fieldState) {

                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 10),
                          child: Text(
                            '$label  ',
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

                  selectedItemsTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                barrierColor: Colors.grey.withOpacity(0.2),
                                key: GlobalKey(),
                            searchable: true,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            chipDisplay: MultiSelectChipDisplay(
                              textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

                              alignment: Alignment.topCenter,
                              onTap: (item) {
                                context.read<ValidationBloc>().add(
                                    MultiSelectItemRemoved(
                                        item: item,
                                        select: this,
                                        selectName: this.name));
                              },
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            dialogHeight: items.isEmpty ? 5 : null,
                            dialogWidth: items.isEmpty ? 5 : null,

                            buttonIcon: Icon(Icons.arrow_drop_down),
                            title: items.isEmpty
                                ? Text('Please Select a $parentLabel')
                                : Text(label),
                            buttonText: Text(prompt),
                            listType: MultiSelectListType.CHIP,
                            items: _buildItemsMulti(items),
                            initialValue:  selectedValues,
                            onConfirm: (values) {
                              fieldState.didChange(values);

                              context.read<ValidationBloc>().add(
                                  MultiSelectChanged(
                                      select: this, value: values));
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
                      ]);
                });
          },
        ),
      ),
    );
  }

  List<MultiSelectItem<String>> _buildItemsMulti(List<DropDownItem> items) {
    List<MultiSelectItem<String>> list = [];
    if (items.isEmpty) {
      return [];
    }
    for (var item in items) {
      list.add(MultiSelectItem(item.value, item.value));
    }
    return list;
  }

  MultiSelectWidget copyWith({
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
    return MultiSelectWidget(
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MultiSelectWidget &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              value == other.value&&
              items == other.items&&
            selectedValues == other.selectedValues;



  @override
  String valueToString() {
    return (value as List).join(',');
  }

}
