import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class FieldHintWidget extends StatelessWidget {
  final String text;
  const FieldHintWidget({
    Key? key,
    required  this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.subtitle1?.copyWith(fontStyle: FontStyle.italic,color: ColorManager.lightPrimary));

  }
}