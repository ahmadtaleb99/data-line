import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'DrawChecboxGroup.dart';
import '../dynamic form/DropDownItem.dart';
import 'IDrawable.dart';


class DrawChildList extends FormElement {
  DrawChildList({Key? key,
    this.visible = false,
    required this.label,
    required this.showIfIsRequired,
    required this.deactivate,
    required this.required,
    required this.isHidden,
     this.value,
    required this.isReadOnly,
    required this.prompt,
    required this.items,
    required this.multiple,
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
  bool ? visible;
  final bool isReadOnly;
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
      padding: this.visible == true ?   const EdgeInsets.only(top: 30) :  const EdgeInsets.only(top: 0),
      child: BlocBuilder<ValidationBloc, ValidationState>(




        builder: (context, state) {
          var parent = state.form!.fields.firstWhere((element) => element.name == this.parentName);
          String parentListLabel = parent.label;
          DrawChildList? list;
          List<DropDownItem> itemsToBuild;
          if (state.childsMap != null && state.childsMap.isNotEmpty && state.childsMap[this.name] != null){
            list = state.childsMap[this.name] as DrawChildList;
            itemsToBuild = list.items;
          }
          else itemsToBuild = [];


          return FormField<dynamic>(
            initialValue: this.value,
              validator: (value) {
                if (value== null )
                  return 'required';
                else
                  return null;
              },
              builder: (FormFieldState<dynamic> fieldState) =>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: Text(
                          // '$label  ${itemsToBuild.isEmpty ? ' - ${parentListLabel}' : itemsToBuild.first.parent} '
                          '$label'
                          ,style: TextStyle(fontSize: 18),
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
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(
          color: Colors.blue,
          width: 2,
          ),
          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Center(
                              child:
                              DropdownButton<dynamic>(
                                  onTap: () {
                                    FocusScopeNode currentFocus = FocusScope.of(context);

                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                  },
                                  underline: Container(),
                                  icon: Padding(
                                    padding: const EdgeInsets.only(left: 99),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  hint: Text(prompt),
                                  disabledHint: Text(prompt),
                                  items: _buildItems(items) ,
                                  value: value ?? null,
                                  onChanged: (value) {
                                    if(items.isNotEmpty) {
                                        context.read<ValidationBloc>().add(
                                            childDropDownChanged(
                                                value: value, childList: this));

                                        fieldState.didChange(value);
                                      }
                                    })
                            ),
                          ),
                        ),
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



  DrawChildList copyWith({String? label,
    String? value,
    bool? deactivated,
    bool? required,
    bool? isHidden,
    bool? isReadOnly,
    String? prompt,
    String? name,
    String? parentName,
    List<DropDownItem>? items,
    bool? multiple}) {
    return DrawChildList(
      label: label ?? this.label,
      deactivate: deactivated ?? this.deactivate,
      required: required ?? this.required,
      isHidden: isHidden ?? this.isHidden,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      prompt: prompt ?? this.prompt,
      name: name ?? this.name,
      parentName: parentName ?? this.parentName,
      items: items ?? this.items,
      multiple: multiple ?? this.multiple,
      showIfValueSelected: this.showIfValueSelected,
      showIfFieldValue: this.showIfFieldValue,
      showIfIsRequired: this.showIfIsRequired,
    );
  }

  List<DropdownMenuItem<dynamic>>? _buildItems(List<DropDownItem> items) {
    if (items.isEmpty)
      return [
        DropdownMenuItem(
            child: Container(
              child: Text(
                prompt,
                style: TextStyle(color: Colors.black.withOpacity(0.45)),
              ),
            ))
      ];
    List<DropdownMenuItem<dynamic>>? list = [];
    for (var item in items) {
      list.add(DropdownMenuItem(child: Text(item.value), value: item.value));
    }
    return list;
  }



  @override
  String valueToString() {
    return this.value.toString();
  }

}
