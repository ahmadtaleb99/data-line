import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:form_builder_test/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:form_builder_test/presentation/form_widgets/matrix_widget/matrix_record_widget.dart';
import 'package:form_builder_test/presentation/resources/color_manager.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class MatrixWidget extends StatelessWidget {
  final MatrixModel model;
  @override
  Widget build(BuildContext context) {
    return FormFieldWidget( model: model,widget: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MatrixRecordWidget(),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r20)),
                primary: ColorManager.black),
            onPressed: () {

            },
            child:   Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  AppStrings.addRecord,
                ),
                  Icon(Icons.add, color: Colors.white)
              ],
            )
        )
      ],
    ));
  }

  const MatrixWidget({
    required this.model,
  });
}
