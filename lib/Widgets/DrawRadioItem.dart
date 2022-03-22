import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/logic/form__bloc.dart';

import 'package:form_builder_test/logic/validation__bloc.dart';

class DrawRadioItem extends StatelessWidget {
  final String label;
  final String value;
  final String parent;
  String? groupValue;

  DrawRadioItem({
    required this.label,
    this.groupValue,
    required this.value, required this.parent,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, BlocFormState>(
      builder: (context, state) {
        return RadioListTile(value: value,
            title: Text(label),
            groupValue: groupValue, onChanged: (value) {
              print(value);
              context.read<FormBloc>().add(RadioGroupValueChanged1(
                  value: value.toString(),
                  groupName: this.parent,
                  id: this.value));
            });
      },
    );
  }


}
