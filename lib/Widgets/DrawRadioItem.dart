import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/logic/form__bloc.dart';

import 'package:form_builder_test/logic/validation__bloc.dart';

class DrawRadioItem extends StatelessWidget {
  final String value;
  final String parent;
  String? groupValue;

  DrawRadioItem({
    Key ? key,
    required this.label,
     this.name,
     this.showIfValueSelected,
     this.showIfFieldValue,
     this.showIfIsRequired,
    this.groupValue,
    required this.value, required this.parent,
  }) : super(key: key);

  final String label;
  final String  ? name;
  final bool ?  showIfValueSelected;
  final String ? showIfFieldValue;
  final bool ? showIfIsRequired;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {

        return RadioListTile(value: value,
            title: Text(label),
            groupValue: groupValue, onChanged: (value) {
              print(value);
              context.read<ValidationBloc>().add(RadioGroupValueChanged(
                  value: value.toString(),
                  groupName: this.parent,
                  id: this.value));
            });
      },
    );
  }


}
