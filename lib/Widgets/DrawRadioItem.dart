import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/logic/form__bloc.dart';

import 'package:form_builder_test/logic/validation__bloc.dart';

class DrawRadioItem extends FormElement {
  final String value;
  final String parent;
  String? groupValue;


  final String label;

  final bool? showIfValueSelected;
  final String? showIfFieldValue;
  final bool? showIfIsRequired;
   Widget?    subTitle;
   Widget?    titleWidget;



  DrawRadioItem({
    Key? key,
    required this.label,
    this.showIfValueSelected,
    this.showIfFieldValue,
    this.showIfIsRequired,
    this.groupValue,
    required this.value,
    required this.parent, this.subTitle,
  }) : super(name: value,label: label);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return RadioListTile(
                contentPadding: EdgeInsets.all(5),
            value: value,
            title: titleWidget ?? Text(label),
            groupValue: groupValue,
            onChanged: (value) {
              print(value);
              context.read<ValidationBloc>().add(
                    RadioGroupValueChanged(
                      value: value.toString(),
                      groupName: this.parent,
                      id: this.value,
                    ),
                  );

            },
          subtitle:   subTitle  ,
            );
      },
    );
  }


  @override
  String valueToString() {
    return this.value.toString();
  }
}
