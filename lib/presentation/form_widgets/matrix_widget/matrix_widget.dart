import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_record/matrix_record_model.dart';
import 'package:form_builder_test/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:form_builder_test/presentation/form_widgets/matrix_widget/matrix_record_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/color_manager.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class MatrixWidget extends StatelessWidget {
  final MatrixModel model;

  @override
  Widget build(BuildContext context) {
    return FormFieldWidget(
        model: model,
        widget: BlocBuilder<FormsBloc, FormsState>(
          builder: (context, state) {
            List<MatrixRecordModel> records = getRecords(state);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // ...getRecords(state).map((record) => const MatrixRecordWidget()),
                ...List.generate(
                    records.length,
                    (index) => MatrixRecordWidget(
                      fields: model.values,
                          onEdit: () {
                            context.read<FormsBloc>().add(
                                MatrixRecordAEditRequested(
                                    index: index, matrixName: model.name));
                            _showEditRecordDialog(context, index);
                          },
                        )),
                Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p12),
                  child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r20)),
                            primary: ColorManager.black),
                        onPressed: () {
                          context.read<FormsBloc>()
                            ..add(NewMatrixRecordAddRequested(
                                index: getRecords(state).length,
                                matrixName: model.name));
                          _showAddRecordDialog(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              AppStrings.addRecord,
                            ),
                            Icon(Icons.add, color: Colors.white)
                          ],
                        )),
                  ),
                )
              ],
            );
          },
        ));
  }

  _showAddRecordDialog(BuildContext context) {
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
              content: dialogBody(
                  model.values.map((e) => e.toWidget()).toList().cast()),
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

  _showEditRecordDialog(BuildContext context, int index) {
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
              content: dialogBody(
                  model.values.map((e) => e.toWidget()).toList().cast()),
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

  List<MatrixRecordModel> getRecords(FormsState state) {
    return state.valuesMap[model.name] as List<MatrixRecordModel>? ?? [];
  }

  Widget dialogBody(List<Widget> widgets) {
    return Container(
      height: 300.0.h,
      width: 300.0.w,
      child: Form(
        child: Scrollbar(
          radius: const Radius.circular(AppRadius.r10),
          thickness: 1,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widgets.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: widgets[index],
              );
            },
          ),
        ),
      ),
    );
  }

  const MatrixWidget({
    required this.model,
  });
}
