import 'dart:developer';

import 'package:datalines/presentation/resources/assets_manager.dart';
import 'package:datalines/presentation/resources/date_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/presentation/forms/submission_details_screen/bloc/submission_details_bloc.dart';
import 'package:datalines/presentation/forms/submission_details_screen/bloc/submission_details_bloc.dart';
import 'package:datalines/presentation/forms/submission_details_screen/view/widgets/field_widget.dart';
import 'package:datalines/presentation/forms/submission_details_screen/view/widgets/label_widget.dart';
import 'package:datalines/presentation/forms/submission_details_screen/view/widgets/value_widget.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubmissionDetailsScreen extends StatelessWidget {
  final List<FormFieldModel> fields;
  final Submission submission;

  @override
  Widget build(BuildContext context) {
    log(submission.fieldEntries.toString());
    return BlocProvider(
      create: (_) => SubmissionDetailsBloc(),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.submissionDetails),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(AppStrings.summery,style: Theme.of(context).textTheme.subtitle2,),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Column(
                children: [
                  SummeryField(
                      icon:const Icon(Icons.date_range_outlined),
                      title: AppStrings.submittedAt + ':',
                      value: DateFormatter.getFormattedDate(
                          submission.submittedAt)),
                  if(submission.updatedAt != null)
                    SummeryField(
                        icon: const  Icon(Icons.edit),
                        title: AppStrings.updatedAt + ':',
                        value: DateFormatter.getFormattedDate(
                            submission.updatedAt!)),
                  SummeryField(
                      icon:   SvgPicture.asset(ImageAssets.nodeIcon),
                      title: AppStrings.node + ':',
                      value: submission.node.name),
                  Divider(thickness: 2),


                ],
              ),
            ),
            Text(AppStrings.values,style: Theme.of(context).textTheme.subtitle2,),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p20,
                ),
                itemCount: fields.length + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppPadding.p37),
                          child: LabelWidget(),
                        )
                      : submission.fieldEntries[index - 1].value != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p14,
                                  horizontal: AppPadding.p12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: FieldWidget(
                                      field: fields[index - 1],
                                    ),
                                    flex: 3,
                                  ),
                                  Expanded(
                                    child: ValueWidget(
                                        field: fields[index - 1],
                                        value: submission
                                            .fieldEntries[index - 1].value),
                                    flex: 2,
                                  )
                                ],
                              ),
                            )
                          : Container();
                },
                separatorBuilder: (BuildContext context, int index) =>
                    submission.fieldEntries[index].value != null
                        ? const Divider(thickness: 2)
                        : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  const SubmissionDetailsScreen({
    required this.fields,
    required this.submission,
  });
}

class SummeryField extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p13),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 10.w,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
        const   Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }

  const SummeryField({
    required this.icon,
    required this.title,
    required this.value,
  });
}
