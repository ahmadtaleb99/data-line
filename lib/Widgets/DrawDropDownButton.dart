import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawDropDownButton extends StatelessWidget {
  const DrawDropDownButton(
      {Key? key,
      required this.label,
      required this.deactivated,
      required this.reqired,
      required this.isHidden,
      required this.isReadOnly,
      required this.prompt,
      required this.items})
      : super(key: key);
  final String label;
  final bool deactivated;
  final bool reqired;
  final bool isHidden;
  final bool isReadOnly;
  final String prompt;
  final List<DropdownMenuItem> items;
  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField<dynamic>(
        hint: Text(prompt), items: items, onChanged: (strig) {

    });
  }
}
