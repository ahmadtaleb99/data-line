import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class FormFieldWidget<T> extends StatelessWidget {
  final String label;
  final Widget widget;
  final FormFieldModel fieldModel;
  final T? initialValue;
  final String? Function(T?)? validator;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(


        builder: (context, state) {

      return AnimatedSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation) =>
              SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, -0.3), end: const Offset(0, 0))
                    .animate(animation),
                child: child,
              ),
          duration: const Duration(milliseconds: 700),
          reverseDuration: const Duration(milliseconds: 100),
          child: isFieldVisible(state)
              ? FormField<T>(
            enabled: true,
                  initialValue: initialValue,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (T? value) {
                    log('validator');
                    if (state.valuesMap[fieldModel.name] !=  null)
                      validator?.call(value);

                else    return AppStrings.fieldReqired;
                  },
                  builder: (fieldState)
                  {
                 return   Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Text(label,
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        widget,
                        if (fieldState.hasError)
                          Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                fieldState.errorText!,
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15,
                                    color: Colors.red[700],
                                    height: 1.5),
                              ))
                      ],
                    );
                  },
                )
              : Container());
    });
  }

  const FormFieldWidget({
    required this.label,
    required this.widget,
    required this.fieldModel,
     this.initialValue,
    this.validator,
  });

  bool isFieldVisible(FormsState state) {
    if (fieldModel.showIfLogicCheckbox == false) return true;

    if (state.valuesMap[fieldModel.showIfFieldName] ==
        fieldModel.showIfFieldValue) return true;

    return false;
  }

  String getText(FormsState state) {
    String? error = state.validationMap[fieldModel.name];
    return error != null ? error : '';
  }
}
