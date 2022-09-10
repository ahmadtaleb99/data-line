import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

void showSnackBar(BuildContext context,String msg) {
  final snackBar = SnackBar(
    content:  Text(msg),
    backgroundColor: ColorManager.lightPrimary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r20)),
    duration: const Duration(seconds: 2),
    width: 200.w,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}