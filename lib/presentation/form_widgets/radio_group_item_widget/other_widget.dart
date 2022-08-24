import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/app_prefs.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

class RadioOtherWidget extends StatelessWidget {
  const RadioOtherWidget(
      {Key? key, required this.groupValue, required this.onSelected, required this.otherRealValue, this.onOtherValueChanged})
      : super(key: key);
  final String groupValue;
  final String otherRealValue;
  final void Function(String?)? onSelected; // final d
  final void Function(String)? onOtherValueChanged; // final d

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String?>(
      title: BlocBuilder<FormsBloc, FormsState>(
        builder: (context, state) {
          return AnimatedSwitcher(
              reverseDuration: Duration(seconds: 0),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              duration: const Duration(milliseconds: 600),
              child: groupValue == AppStrings.otherDelimiter
                  ? Padding(
                padding: const EdgeInsets.only(right: 100),
                child: TextFormField(
                  initialValue: otherRealValue,
                  onChanged: onOtherValueChanged,
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
              ));
        },
      ),
      value: AppStrings.otherDelimiter,
      groupValue: groupValue,
      onChanged: onSelected,
    );
  }
}
