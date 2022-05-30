
import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:hive/hive.dart';

part 'IFormModel.g.dart';
@HiveType(typeId: 47)
  abstract class IFormModel  {
  IFormModel copyWith();
  dynamic value;
  FormElementWidget toWidget ();
  String valueToString();
}