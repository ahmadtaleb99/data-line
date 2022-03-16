import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DropDownItemWidget.dart';

class DrawChildList extends StatelessWidget {
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
      builder: (context, state) {
        print('in view list is : ' + state.childLists.toString());
        // print('in view list is : ' + state.childLists.first.toString());

        for(var value in state.childLists){
          print('in view :: list name : ${value.name}');
        }

        return DropdownButtonFormField<dynamic>(
            hint: Text(prompt),
            items:   _buildItems([]),
            onChanged: (value) {
            });
      },
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
