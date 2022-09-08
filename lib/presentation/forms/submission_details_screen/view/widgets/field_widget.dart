import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/presentation/submission_details_screen/view/submisson_details_screen.dart';

class FieldWidget extends StatelessWidget {
  final FormFieldModel field;

  @override
  Widget build(BuildContext context) {
    return    Row(
      children: [
        Text(field.label, style: Theme.of(context).textTheme.subtitle1),
        SizedBox(
          width: 5.w,
        ),
        FieldHintWidget(text: field.getHintName(),)
      ],
    );

  }

  const FieldWidget({
    required this.field,
  });
}