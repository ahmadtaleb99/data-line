// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/presentation/common/dialogs/warning_dialog.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/forms/submission_details_screen/bloc/submission_details_bloc.dart';
import 'package:datalines/presentation/forms/submission_details_screen/view/submission_details_screen.dart';
import 'package:datalines/presentation/forms/submissions_screen/bloc/submissions_bloc.dart';
import 'package:datalines/presentation/forms/submissions_screen/widgets/submission_card.dart';
import 'package:datalines/presentation/forms/update_submisson/view/update_submisson_screen.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';

class SubmissionsScreen extends StatelessWidget {
  const SubmissionsScreen({Key? key, required this.formModel})
      : super(key: key);
  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formModel.name + ' ${AppStrings.submissions}'),
      ),
      body: BlocBuilder<SubmissionsBloc, SubmissionsState>(
        buildWhen: (p, c) {
          return p.flowState != c.flowState;
        },
        builder: (context, state) {
          if (state.flowState != null) {
            var widget = state.flowState
                .getWidget(context, SubmissionsScreenView(formModel: formModel), () {});
            return widget;
          } else {
            return SubmissionsScreenView(formModel: formModel);
          }
        },
      ),
      // body : NewWidget(formModel: formModel,),
    );
  }
}

class SubmissionsScreenView extends StatelessWidget {
  const SubmissionsScreenView({
    Key? key,
    required this.formModel,
  }) : super(key: key);

  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubmissionsBloc, SubmissionsState>(

        listener: (context, state) {


          if(state.flowState is EmptyState){
            context.read<FormsBloc>().add(FormSubmissionBecameEmpty(formModel.id));
          }
        },
      builder: (context, state) {
        FormsBloc formsBloc = context.read<FormsBloc>();

        return ListView.separated(
            itemBuilder: (context, index) => SubmissionCard(
                  formModel: formModel,
                  onUpdate: () {
                    formsBloc.add(SubmissionUpdateRequested(
                        formModel, state.submissions[index]));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                  value: formsBloc,
                                  child: UpdateSubmissionScreen(
                                      formModel: formModel,
                                      submission: state.submissions[index]),
                                ))).then((value) => context
                        .read<SubmissionsBloc>()
                        .add(SubmissionsRequested(formModel)));
                  },
                  onDelete: () {
                    showWarningDialog(context,
                        text: AppStrings.deleteSubmissionWarningMsg,
                        onConfirmBtnTap: () {
                      context
                          .read<SubmissionsBloc>()
                          .add(SubmissionDeleted(state.submissions[index]));
                      Navigator.pop(context);
                    });
                  },
                  onView: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubmissionDetailsScreen(
                                fields: formModel.fields,
                                submission: state.submissions[index])));
                  },
                  entries: state.submissions[index].fieldEntries,
                ),
            separatorBuilder: (context, index) =>
                const Padding(padding: EdgeInsets.all(AppPadding.p20)),
            itemCount: state.submissions.length);
      },
    );
  }
}
