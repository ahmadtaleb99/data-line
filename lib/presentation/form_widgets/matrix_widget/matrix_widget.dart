import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_record/matrix_record_model.dart';
import 'package:datalines/presentation/common/dialogs/warning_dialog.dart';
import 'package:datalines/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:datalines/presentation/form_widgets/matrix_widget/matrix_record_widget.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';

import 'widgets/matrix_edit_record_dialog.dart';
import 'widgets/matrix_new_record_dialog.dart';

class MatrixWidget extends StatefulWidget {
  final MatrixModel model;

  @override
  State<MatrixWidget> createState() => _MatrixWidgetState();

  const MatrixWidget({
    required this.model,
  });
}

class _MatrixWidgetState extends State<MatrixWidget> {
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        List<MatrixRecordModel> records = getRecords(state);

        return FormFieldWidget(
            model: widget.model,
            validator: (value) {
              return context.read<FormsBloc>().validateMatrix(widget.model);
            },
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...List.generate(
                    records.length,
                    (index) => MatrixRecordWidget(
                          onDelete: () {
                            showWarningDialog(context,
                                title: AppStrings.warning, onConfirmBtnTap: () {
                              context.read<FormsBloc>().add(MatrixRecordDeleted(
                                  matrixName: widget.model.name,
                                  recordIndex: index));
                              Navigator.pop(context);
                            }, text: AppStrings.deleteRecordMsg);
                          },
                          record: state.valuesMap[widget.model.name][index],
                          fields: widget.model.values,
                          onEdit: () {
                            context.read<FormsBloc>().add(
                                MatrixRecordAEditRequested(
                                    index: index,
                                    matrixName: widget.model.name));
                            showEditRecordDialog(context, index, widget.model);
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
                          if (widget.model.maxRecordsCount == records.length)
                            setState(() => showError = true);
                          else {
                            _hideError();
                            context.read<FormsBloc>()
                              ..add(NewMatrixRecordAddRequested(
                                  index: getRecords(state).length,
                                  matrixName: widget.model.name));
                            showAddRecordDialog(context, widget.model).then(
                                (value) => context.read<FormsBloc>()
                                  ..add(MatrixSubmitCanceled(
                                      matrixName: widget.model.name)));
                          }
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
                ),
                if (showError)
                  Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p13, top: AppPadding.p8),
                      child: Text(
                        AppStrings.maxRecordCountErrorMsg +
                            widget.model.maxRecordsCount.toString(),
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 13,
                            color: Colors.red[700],
                            height: 1.5),
                      ))
              ],
            ));
      },
    );
  }


  _hideError(){
    if(showError ==true )  setState(() => showError = false);
  }
  List<MatrixRecordModel> getRecords(FormsState state) {
    return state.valuesMap[widget.model.name] as List<MatrixRecordModel>? ?? [];
  }
}
