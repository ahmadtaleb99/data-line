import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:datalines/presentation/form_widgets/matrix_widget/widgets/matrix_dialog.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:datalines/presentation/resources/routes_manager.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';

Future showAddRecordDialog(BuildContext context, MatrixModel model) async {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  FormsBloc bloc = context.read<FormsBloc>();

  return await showDialog(
      useRootNavigator: false,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: bloc,
          child: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: BlocBuilder<FormsBloc, FormsState>(
              builder: (context, state) {
                return AlertDialog(
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
                  content: Form(
                    key: _key,
                    child: MatrixDialog(
                        widgets: model.values.map((e) => e.toWidget())
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
                                        borderRadius:
                                        BorderRadius.circular(
                                            AppRadius.r20))),
                                onPressed: () {

                                  if(state.tempRecord!.areAllValuesNull()){
                                    CoolAlert.show(context: context,
                                        type: CoolAlertType.error,
                                        title: AppStrings.error,
                                        text: AppStrings.cantSubmitEmptyRecordMsg);
                                  }
                                else  if (_key.currentState!.validate()) {
                                  Navigator.pop(context);
                                    bloc.add(
                                        MatrixNewRecordSubmitted());
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
                                Navigator.pop(context);
                                // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                                //   bloc.add(MatrixSubmitCanceled(matrixName: model.name));
                                // });
                              },
                              child: const Text(AppStrings.cancel),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      });
}
