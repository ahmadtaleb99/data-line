import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class FormFieldWidget extends StatelessWidget {
  final String label;
  final Widget field;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:  MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(label,style: Theme.of(context).textTheme.subtitle1),
        ),
        SizedBox(height: 10.h,),
        field

      ],
    );
  }

  const FormFieldWidget({
    required this.label,
    required this.field,
  });
}
