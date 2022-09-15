
import 'package:datalines/presentation/common/animation/animation_box.dart';
import 'package:datalines/presentation/resources/assets_manager.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../common/dialogs/custom_dialog.dart';

class SyncLoadingDialog extends StatelessWidget {

  final double submissionChunkPercent;
  final double submissionSyncPercent;


  @override
  Widget build(BuildContext context) {
    return CustomDialog(children: [
      AnimationBox(AnimationAssets.sync),

      LinearPercentIndicator(
        width: MediaQuery.of(context).size.width /2,
        animation: true,
        lineHeight: 20.0,
        animationDuration: 2500,
        percent: 0.8,
        center: Text("80.0%"),
        barRadius: Radius.circular(AppRadius.r20),
        progressColor: ColorManager.lightPrimary,
      ),

    ]);

  }

  const SyncLoadingDialog({
    required this.submissionChunkPercent,
    required this.submissionSyncPercent,
  });
}