
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/forms/submission_details_screen/view/widgets/field_widget.dart';
import 'package:form_builder_test/presentation/forms/submission_details_screen/view/widgets/label_widget.dart';
import 'package:form_builder_test/presentation/forms/submission_details_screen/view/widgets/value_widget.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class SubmissionDetailsScreen extends StatelessWidget {
  final List<FormFieldModel> fields;
  final Submission submission;
  @override
  Widget build(BuildContext context) {

    log(submission.fieldEntries.toString());
    log(fields.toString());
    return Scaffold(
      appBar: AppBar(
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p20,
        ),
        itemCount: fields.length+1,

        itemBuilder: (context, index) {

          return index == 0
              ? const Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppPadding.p37),
            child:  LabelWidget(),
          )
              :   submission.fieldEntries[index-1].value != null  ? Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p14,horizontal: AppPadding.p12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: FieldWidget(field: fields[index-1],),flex: 3,),
                Expanded(child: ValueWidget(field: fields[index-1],value: submission.fieldEntries[index-1].value),flex: 2,)
              ],
            ),
          ) :  Container();
        },
        separatorBuilder: (BuildContext context, int index) =>  submission.fieldEntries[index].value != null ? const Divider(thickness: 2) : SizedBox(),
      ),
    );
  }




  const SubmissionDetailsScreen({
    required this.fields,
    required this.submission,
  });
}
