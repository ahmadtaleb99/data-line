import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        const BuildRecords(),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p18),
          child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r20)),
                  primary: ColorManager.black),
              onPressed: () {
                _showAddRecordDialog(context);
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
          ),
        )
      ],
    ));
  }

  _showAddRecordDialog(BuildContext context){
    model.values.forEach((element) {
      log(element.runtimeType.toString());
    });
    showDialog(
        useRootNavigator: false,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const  Text(AppStrings.addNewRecord),
            content: dialogBody(model.values.map((e) => e.toWidget()).toList().cast()),
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
                                  borderRadius: BorderRadius.circular(AppRadius.r20))),
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
                                borderRadius: BorderRadius.circular(AppRadius.r20))),
                        onPressed: () {
                          Navigator.pop(context);

                        },
                        child: const  Text(AppStrings.cancel),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
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
