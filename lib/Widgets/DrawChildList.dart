import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'DrawChecboxGroup.dart';
import 'DropDownItemWidget.dart';
import 'IDrawable.dart';

class DrawChildList extends IDrawable {
  DrawChildList({Key? key,
    this.visible = false,
    required this.label,
    required this.showIfIsRequired,
    required this.deactivated,
    required this.required,
    required this.isHidden,
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

  String? value;
  final String label;
  final bool deactivated;
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

  List<DropDownItemWidget> items;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      // buildWhen: (p, current) {
      //   for (var kza in current.childLists!) {
      //     if (kza.name == this.name) return true;
      //   }
      //   return false;
      // },
      builder: (context, state) {
        var parent = state.formElements!.firstWhere((element) => element.name == this.parentName);
        String parentListLabel = parent.label;
        DrawChildList? list;
        List<DropDownItemWidget> itemsToBuild;
        if (state.childsMap != null && state.childsMap.isNotEmpty){
          list = state.childsMap[this.name] as DrawChildList;
          itemsToBuild = list.items;
        }
        else itemsToBuild = [];


        return FormField<dynamic>(
            validator: (value) {
              if (list?.value == null )
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
                        '$label  ${itemsToBuild.isEmpty ? ' - ${parentListLabel}' : itemsToBuild.first.parent} '
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
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black38,
                                width: 3), //border of dropdown button
                            borderRadius: BorderRadius.circular(
                                50), //border raiuds of dropdown button
                            boxShadow: <BoxShadow>[
                              //apply shadow on Dropdown button
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.57), //shadow for button
                                  blurRadius: 5) //blur radius of shadow
                            ]),
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
                                // value: state.childList != null && state.childList!.name == this.name ? state.childList!.value : null,
                                // items:   state.childList != null && state.childList!.name == this.name ? _buildItems(state.childList!.items)
                                items: itemsToBuild.isEmpty ? _buildItems([]) : _buildItems(itemsToBuild)  ,
                                value: list != null ? list.value : null,
                                onChanged: (value) {
                                  if(itemsToBuild.isNotEmpty)
                                  context
                                      .read<ValidationBloc>()
                                      .add(childDropDownChanged(value: value, childList: this));
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
    List<DropDownItemWidget>? items,
    bool? multiple}) {
    return DrawChildList(
      label: label ?? this.label,
      deactivated: deactivated ?? this.deactivated,
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

  List<DropdownMenuItem<dynamic>>? _buildItems(List<DropDownItemWidget> items) {
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




}
