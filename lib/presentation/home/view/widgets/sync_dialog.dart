// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:datalines/presentation/common/animation/animation_box.dart';
import 'package:datalines/presentation/common/buttons/custom_button_widget.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/forms/bloc/view_objects/sync_form_progress.dart';
import 'package:datalines/presentation/resources/assets_manager.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../common/dialogs/custom_dialog.dart';

class SyncLoadingDialog extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CustomDialog(children: [
        const AnimationBox(AnimationAssets.sync),
        BlocSelector<FormsBloc, FormsState, SyncFormProgress>(
          selector: (state) {
            return state.syncFormProgress;
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.submissionsSyncedSuccessfully + ':',
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.start,
                      ),
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p12),
                      child: ProgressCustomWidget(
                        progress: state.submissionsChunksProgress.toDouble() / 100,
                        text: state.submissionsChunksProgress.toString()+'%',
                      ),
                    ),
                    if(state.requiresUploadProgress)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p12),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppStrings.uploadProgress + ':',
                              style: Theme.of(context).textTheme.headline3,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ProgressCustomWidget(
                            progress: state.submissionUploadProgress.toDouble() / 100,
                            text: state.submissionUploadProgress.toString()+'%',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                        height: 30.h,
                        child: CustomButtonWidget(
                          color: ColorManager.lightPrimary,
                          text: AppStrings.stopProcess,
                          onPressed: () {
                            context.read<FormsBloc>().add(const FormSyncRequestCanceled());
                            Navigator.pop(context);
                          },
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ]),
    );
  }

  
}

class ProgressCustomWidget extends StatelessWidget {
  const ProgressCustomWidget({
    Key? key,
    required this.progress,
    required this.text,
  }) : super(key: key);

  final double progress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 20.0.h,
      animateFromLastPercent: true,
      // animationDuration: 2500,

      percent: progress,
      center: Text(
        text,
        style: TextStyle(color: ColorManager.white),
      ),
      padding: EdgeInsets.zero,
      barRadius: Radius.circular(AppRadius.r20),
      alignment: MainAxisAlignment.center,
      progressColor: ColorManager.lightPrimary,
    );
  }
}
