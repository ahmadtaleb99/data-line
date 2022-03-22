import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
