import 'package:flutter/material.dart';
import 'package:form_builder_test/presentation/resources/color_manager.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text(AppStrings.field,
            style: TextStyle(
                color: ColorManager.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        Text(AppStrings.value,
            style: TextStyle(
                color: ColorManager.black,

                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}