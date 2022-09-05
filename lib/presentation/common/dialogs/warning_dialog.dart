import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

void showWarningDialog(BuildContext context,
    {required String title,
    required String text,
    void Function()? onConfirmBtnTap,
    void Function()? onCancelBtnTap}) {
  CoolAlert.show(
      title: title,
      context: context,
      type: CoolAlertType.warning,
      text: text,
      showCancelBtn: true,
      onConfirmBtnTap: onConfirmBtnTap,
      onCancelBtnTap: onCancelBtnTap);
}
