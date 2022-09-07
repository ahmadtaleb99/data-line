import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class MatrixFieldWidget<T> extends StatelessWidget {
  final Widget widget;
  final MatrixFieldModel model;
  final String? Function(T?)? validator;
  final Function(T?)? onSaved;
  final bool? showLabel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(


        builder: (context, state) {
          return FormField<T>(
            onSaved: onSaved,
            enabled: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              // if( context.read<FormsBloc>().getMatrixFieldValue(model.fieldName) == null    )
              //   return AppStrings.fieldReqired;
              //
              // else
                return validator?.call(value);
            },
            builder: (fieldState)
            {
              // if(state.validationMap[model.name] == true) {
              //   log(state.validationMap.toString());
              //   fieldState.validate();
              // }
              return   Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 if(showLabel!) Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Text(model.label,
                            style: Theme.of(context).textTheme.subtitle1),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                  widget,
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
          );
        });
  }

  const   MatrixFieldWidget({
    required this.widget,
    required this.model,
    this.validator,
    this.onSaved,
    this.showLabel = true,
  });

}
