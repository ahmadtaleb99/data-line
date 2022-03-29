import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/logic/form__bloc.dart';

import 'package:form_builder_test/logic/validation__bloc.dart';

import 'DrawRadioItem.dart';
import 'DrawTextField.dart';

class DrawRadioGroup extends FormElement {
  DrawRadioGroup({
    Key? key,
    required this.label,
    required this.name,
    this.visible,
    this.isOtherSelected = false,
    this.value = null,
    required this.required,
    required this.other,
    required this.children,
    required this.showIfValueSelected,
    this.showIfFieldValue,
    this.showIfIsRequired,
  }) : super(
            label: label,
            key: key,
            name: name,
            visible: visible,
            required: required,
            showIfValueSelected: showIfValueSelected,
            showIfFieldValue: showIfFieldValue,
            showIfIsRequired: showIfIsRequired);

  final String label;
  String? value;
  final String name;
  final bool required;
  final bool other;
  bool? visible;
  bool? isOtherSelected;
  final List<DrawRadioItem> children;
  final bool showIfValueSelected;
  final String? showIfFieldValue;
  final bool? showIfIsRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.other == true
          ? const EdgeInsets.symmetric(vertical: 0)
          : const EdgeInsets.symmetric(vertical: 20),
      child: FormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          print(this.value.toString() + ' asdsadasdasd');
          if (this.value == null && required) {
            return '$label is required';
          }
        },
        builder: (fieldState) {
          return Column(
            children: [
              BlocConsumer<ValidationBloc, ValidationState>(

              listener: (context, state) {
                fieldState.validate();
              },
                  builder: (context, state) {
                      var children;
                      if (state.radioGroup != null) {
                        children = state.radioGroup!.children;
                      }

                      {
                        children = this.children;
                      }
                    if (other == true)
                      children.last.titleWidget = AnimatedSwitcher(
                          reverseDuration: Duration(seconds: 0),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                          duration: Duration(milliseconds: 600),
                          child: isOtherSelected!
                              ? Padding(
                                padding: const EdgeInsets.only(right: 100),
                                child: TextFormField(
                                    decoration:
                                        InputDecoration(label: Text('other')),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return 'other is required';
                                    },
                                    autofocus: true,
                                  ),
                              )
                              : Align(
                                  child: Text('other'),
                                  alignment: Alignment.centerLeft,
                                ));

                    return Column(
                      children: [
                        Text(label),
                        ...children,
                      ],
                    );
                  },
                  ),
              if (fieldState.hasError)
                Padding(
                    padding: const EdgeInsets.only(left: 8, top: 10),
                    child: Text(
                      fieldState.errorText!,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 13,
                          color: Colors.red[700],
                          height: 0.5),
                    ))
            ],
          );
        },
      ),
    );
  }
}
