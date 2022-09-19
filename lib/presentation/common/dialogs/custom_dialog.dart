import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    ),

      ),
    );
  }

    const CustomDialog({
    required this.children,
  });
}
