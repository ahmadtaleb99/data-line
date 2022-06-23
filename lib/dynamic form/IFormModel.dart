
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:hive/hive.dart';

part 'IFormModel.g.dart';
@HiveType(typeId: 47)
  abstract class IFormModel {
  IFormModel copyWith({dynamic value});
  dynamic value;
  final String label;
  final String name;
  FormElementWidget toWidget ();
  String valueToString();

  IFormModel({
    required this.label,
    required this.name,
  });
}