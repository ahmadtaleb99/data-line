import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawDropDownButton extends StatelessWidget {
  const DrawDropDownButton(
      {Key? key,
      required this.label,
      required this.deactivated,
      required this.reqired,
      required this.isHidden,
      required this.isReadOnly,
      required this.prompt,
      required this.items, required this.relatedToParent, this.parentName})
      : super(key: key);
  final String label;
  final bool deactivated;
  final bool reqired;
  final bool isHidden;
  final bool isReadOnly;
  final String prompt;
  final String ? parentName;
  final bool relatedToParent;

  final List<DropdownMenuItem> items;
  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField<dynamic>(

        hint: Text(prompt), items: relatedToParent ? [DropdownMenuItem(child: Container(),)] : items, onChanged: (value) {
          context.read<ValidationBloc>().add(ParentDropListChanged(drawDropDownButton: this, parent: value));
    });
  }
}
