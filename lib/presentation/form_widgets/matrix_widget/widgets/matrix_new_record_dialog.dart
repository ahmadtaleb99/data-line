import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:form_builder_test/presentation/form_widgets/matrix_widget/widgets/matrix_dialog.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/color_manager.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

showAddRecordDialog(BuildContext context,MatrixModel model) {
  FormsBloc bloc = context.read<FormsBloc>();
  model.values.forEach((element) {
    log(element.runtimeType.toString());
  });
  showDialog(
      useRootNavigator: false,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: bloc,
          child: AlertDialog(
            title: Row(
              children: [
                const Text(AppStrings.addNewRecord),
                SizedBox(
                  width: 10.w,
                ),
                Icon(
                  Icons.add,
                  color: ColorManager.primary,
                ),
              ],
            ),
            content: MatrixDialog(
              widgets :   model.values.map((e) => e.toWidget()).toList().cast()),
            actions: [
              Padding(
                padding: const EdgeInsets.all(AppRadius.r12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(AppRadius.r20))),
                          onPressed: () {

                            Navigator.pop(context);
                            bloc.add(
                                MatrixRecordSubmitted());
                          },
                          child: const Text(AppStrings.submit)),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(AppRadius.r20))),
                        onPressed: () {
                          Navigator.pop(context);
                          bloc.add(
                              MatrixSubmitCanceled(matrixName: model.name));
                        },
                        child: const Text(AppStrings.cancel),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      });
}
