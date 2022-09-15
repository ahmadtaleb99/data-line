
import 'dart:developer';

import 'package:datalines/presentation/common/animation/animation_box.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/forms/bloc/view_objects/sync_form_progress.dart';
import 'package:datalines/presentation/resources/assets_manager.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../common/dialogs/custom_dialog.dart';

class SyncLoadingDialog extends StatelessWidget {

  // final double submissionChunkPercent;
  // final double submissionSyncPercent;


  @override
  Widget build(BuildContext context) {
    return CustomDialog(children: [
      AnimationBox(AnimationAssets.sync),

      BlocSelector<FormsBloc, FormsState, int>(
  selector: (state) {
  return state.syncFormProgress.submissionsChunksProgress;
  },
  builder: (context, state) {
    return LinearPercentIndicator(
        width: MediaQuery.of(context).size.width /2,
        animation: true,
        lineHeight: 20.0,
        // animationDuration: 2500,
        percent: state / 100,
        center: Text(state.toString()+'%'),
        barRadius: Radius.circular(AppRadius.r20),
        progressColor: ColorManager.lightPrimary,
      );
  },
),

      BlocSelector<FormsBloc, FormsState, int>(
  selector: (state) {
    return state.syncFormProgress.submissionSyncPercent;

  },
  builder: (context, state) {
    log('builtsttttttttttttttttttttttttttttttttttttt ${state.toString()}');
    return LinearPercentIndicator(
        width: MediaQuery.of(context).size.width /2,
        animation: true,
        lineHeight: 20.0,
        // animationDuration: 2500,
        percent: state.toDouble() / 100 ,
        center: Text(state.toString()+'%'),
        barRadius: Radius.circular(AppRadius.r20),
        progressColor: ColorManager.lightPrimary,
      );
  },
),

    ]);

  }

  // const SyncLoadingDialog({
  //   required this.submissionChunkPercent,
  //   required this.submissionSyncPercent,
  // });
}