import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:form_builder_test/logic/validation__bloc.dart';

import 'DrawRadioItem.dart';

class DrawRadioGroup extends StatelessWidget {
  final String label;
  final String value;
  final String name;
  final bool required;
  final bool other;
  final List<DrawRadioItem> children;
  final bool  showIfValueSelected;
  final String ? showIfFieldValue;

  const DrawRadioGroup({

    required this.label,
    required this.name,
    required this.value,
    required this.required,
    required this.other,
    required this.children, required this.showIfValueSelected, this.showIfFieldValue,
  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        var children;
        if(state.radioGroup != null)
          children =state.radioGroup!.children;

        children = this.children;

        return Column(
          children: [
            Text(label),
            ...children

          ],
        );
      },
    );
  }


}
