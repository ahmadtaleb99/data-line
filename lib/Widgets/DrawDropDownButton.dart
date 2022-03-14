import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DropDownItemWidget.dart';

class DrawDropDownButton extends StatelessWidget {
  DrawDropDownButton(
      {Key? key,
      required this.label,
      required this.deactivated,
      required this.required,
      required this.isHidden,
      required this.isReadOnly,
      required this.prompt,
      required this.items,
      required this.relatedToParent,
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
  final bool relatedToParent;

  List<DropDownItemWidget> items;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        print(state.childItems.toString()+' new stateeeeeeeeeeeeeee');
        return DropdownButtonFormField<dynamic>(
            hint: Text(prompt),
            items: relatedToParent
                ? _buildItems(state.childItems)
                : _buildItems(items),
            onChanged: (value) {
              if(!relatedToParent) {
                context.read<ValidationBloc>().add(ParentDropListChanged(
                    drawDropDownButton: this, parent: value.toString()));
                print(value.toString() + ' eveeent ');
              }


            });
      },
    );
  }
}

List<DropdownMenuItem<dynamic>>? _buildItems(List<DropDownItemWidget> items) {
  List<DropdownMenuItem<dynamic>>? list = [];
  print('iteemsss to draw  ${items.toString()}');
  for (var item in items) {
      print('item to draw : : ${item.value}');
    list.add(DropdownMenuItem(child: Text(item.value),value: item.value,));
  }
  return list;
}
