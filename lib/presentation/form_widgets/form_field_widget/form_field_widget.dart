import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class FormFieldWidget<T> extends StatelessWidget {
  final Widget widget;
  final bool? didChange;
  final FormFieldModel model;
  final T? initialValue;
  final String? Function(T?)? validator;
  final Function(T?)? onSaved;
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
          child: isFieldVisible(state) ? FormField<T>(
            onSaved: onSaved,
            enabled: true,
            initialValue: initialValue,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){


              if( state.valuesMap[model.name] == null && model.required   )
                return AppStrings.fieldReqired;

              else return validator?.call(value);
            },
            builder: (fieldState)
            {
              if(state.validationMap[model.name] == true) {
                log(state.validationMap.toString());
                fieldState.validate();
              }
              return   Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Text(model.label,
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(alignment:Alignment.centerLeft,child: widget),
                  if (fieldState.hasError)
                    Padding(
                        padding: const EdgeInsets.only(left: AppPadding.p13,top:AppPadding.p8),
                        child: Text(
                          fieldState.errorText!,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 13,
                              color: Colors.red[700],
                              height: 1.5),
                        ))
                ],
              );
            },
          ) : Container());
    });
  }

  const   FormFieldWidget({
    required this.widget,
     this.didChange,
    required this.model,
     this.initialValue,
    this.validator,
    this.onSaved,
  });

  bool isFieldVisible(FormsState state) {
    if (model.showIfLogicCheckbox == false) return true;

    if (state.valuesMap[model.showIfFieldName] ==
        model.showIfFieldValue) return true;

    return false;
  }

  // String getText(FormsState state) {
  //   String? error = state.validationMap[fieldModel.name];
  //   return error != null ? error : '';
  // }
}
