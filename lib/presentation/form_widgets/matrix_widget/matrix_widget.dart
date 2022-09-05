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

import 'widgets/matrix_edit_record_dialog.dart';
import 'widgets/matrix_new_record_dialog.dart';

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
                ...List.generate(
                    records.length,
                    (index) => MatrixRecordWidget(
                      record: state.valuesMap[model.name][index],
                      fields: model.values,
                          onEdit: () {
                            context.read<FormsBloc>().add(
                                MatrixRecordAEditRequested(
                                    index: index, matrixName: model.name));
                            showEditRecordDialog(context, index,model);
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
                          context.read<FormsBloc>()..add(NewMatrixRecordAddRequested(index: getRecords(state).length, matrixName: model.name));
                          showAddRecordDialog(context,model);
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



  List<MatrixRecordModel> getRecords(FormsState state) {
    return state.valuesMap[model.name] as List<MatrixRecordModel>? ?? [];
  }


  const MatrixWidget({
    required this.model,
  });
}
