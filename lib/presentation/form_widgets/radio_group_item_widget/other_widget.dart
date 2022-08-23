import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/app_prefs.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

class RadioOtherWidget extends StatelessWidget {
  const RadioOtherWidget(
      {Key? key, required this.groupValue, required this.onChanged})
      : super(key: key);
  final String groupValue;
  final  void Function(String?)? onChanged; // final d

  @override
  Widget build(BuildContext context) {
    return          RadioListTile<String?>(
      title: AnimatedSwitcher(
          reverseDuration: Duration(seconds: 0),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(
                opacity: animation,
                child: child,
              ),
          duration: const Duration(milliseconds: 600),
          child: groupValue == 'other'
              ? Padding(
            padding: const EdgeInsets.only(right: 100),
            child: TextFormField(
              // initialValue: otherValue,
              onChanged: (value){},
              decoration:
              const InputDecoration(label: Text(AppStrings.other)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) return AppStrings.fieldReqired;
              },
            ),
          )
              : const Align(
            child: Text(AppStrings.other),
            alignment: Alignment.centerLeft,
          )),
      value: 'other',
      groupValue: groupValue,
      onChanged: onChanged,
    );

  }
}
