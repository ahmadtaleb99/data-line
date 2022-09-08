import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:datalines/presentation/form_widgets/matrix_widget/widgets/matrix_dialog.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';

import '../../../resources/color_manager.dart';

showEditRecordDialog(BuildContext context, int index, MatrixModel model) {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
          child: Builder(builder: (context) {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AlertDialog(
                title: Row(
                  children: [
                    const Text(AppStrings.editRecord),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.edit,
                      color: ColorManager.primary,
                    ),
                  ],
                ),
                content: Form(
                  key: _key,
                  child: MatrixDialog(
                      widgets: model.values
                          .map((e) => e.toWidget())
                          .toList()
                          .cast()),
                ),
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
                                      borderRadius: BorderRadius.circular(
                                          AppRadius.r20))),
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  context
                                      .read<FormsBloc>()
                                      .add(MatrixEditRecordSubmitted());
                                  Navigator.pop(context);
                                }
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
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  showCancelBtn: true,
                                  text: AppStrings.editCancelMsg,
                                  title: AppStrings.warning,
                                  cancelBtnText: AppStrings.back,
                                  onCancelBtnTap: () =>
                                      Navigator.pop(context),
                                  onConfirmBtnTap: () {

                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                  });
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
          }),
        );
      });
}
