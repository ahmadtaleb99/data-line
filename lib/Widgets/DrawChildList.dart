import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DropDownItemWidget.dart';

class DrawChildList extends StatelessWidget{
  DrawChildList(
      {Key? key,
        required this.label,
        required this.deactivated,
        required this.required,
        required this.isHidden,
        required this.isReadOnly,
        required this.prompt,
        required this.items,
        this.parentName,
        required this.name})
      : super(key: key);
  final String label;
   String  ? value;
  final bool deactivated;
  final bool required;
  final bool isHidden;
  final bool isReadOnly;
  final String prompt;
  final String name;
  final String? parentName;

  List<DropDownItemWidget> items;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
        buildWhen: (p,current) {

          for(var kza in current.childLists!){
            if(kza.name == this.name) return true;
          }
          return false;
        },
      builder: (context, state) {

        DrawChildList ? list ;
        if(state.childLists != null && state.childLists!.isNotEmpty)
         list = state.childLists!.lastWhere((element) => element.name == this.name);
        return  DropdownButtonFormField<dynamic>(
            hint: Text(prompt),
            // value: state.childList != null && state.childList!.name == this.name ? state.childList!.value : null,
            // items:   state.childList != null && state.childList!.name == this.name ? _buildItems(state.childList!.items)
            items: list != null  ?   _buildItems(list.items) : _buildItems([]),
            value: list!= null ? list.value : null
            ,onChanged: (value) {
            });
      },
    );
  }

  DrawChildList copyWith({
    String? label,
    String? value,
    bool? deactivated,
    bool? required,
    bool? isHidden,
    bool? isReadOnly,
    String? prompt,
    String? name,
    String? parentName,
    List<DropDownItemWidget>? items,
  }) {
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
    );
  }
}

List<DropdownMenuItem<dynamic>>? _buildItems(List<DropDownItemWidget> items) {
  if(items.isEmpty)
    return [DropdownMenuItem(child: Text('.value'),value:' item.value')];
  List<DropdownMenuItem<dynamic>>? list = [];
  print('iteemsss to draw  ${items.toString()}');
  for (var item in items) {
    print('item to draw : : ${item.value}');
    list.add(DropdownMenuItem(child: Text(item.value),value: item.value,));
  }
  return list;
}










