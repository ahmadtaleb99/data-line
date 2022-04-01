import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';


part 'DropDownItem.g.dart';
@HiveType(typeId: 21)

class DropDownItem extends Equatable implements IFormModel {

  @HiveField(1)

  final String? parent;
  @HiveField(2)

  final String value;
  @HiveField(3)

  final String status;


  factory DropDownItem.fromJson(json) {
    return DropDownItem(
        value: json['value'], status: json['status'], parent: json['parent']);
  }

  const DropDownItem({
    this.parent,
    required this.value,
    required this.status,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [value, status, parent];

  @override
  Map<String, dynamic> fomrElementtoJson(formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
  }

  @override
  FormElement toWidget() {
    // TODO: implement getFormElement
    throw UnimplementedError();
  }
}
