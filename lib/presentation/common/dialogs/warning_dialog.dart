import 'package:cool_alert/cool_alert.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';

  void showWarningDialog(BuildContext context,
    { String? title,
      required String  text,
    void Function()? onConfirmBtnTap,
    void Function()? onCancelBtnTap}) {
  CoolAlert.show(
      title: title ??  AppStrings.warning,
      context: context,
      type: CoolAlertType.warning,
      text: text,
      showCancelBtn: true,
      confirmBtnColor: ColorManager.primary,
      onConfirmBtnTap: onConfirmBtnTap,
      onCancelBtnTap: onCancelBtnTap);
}
