import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel';

class DropDownItem extends Equatable implements IFormModel {
  final String? parent;
  final String value;
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
  FormElement getFormElement() {
    // TODO: implement getFormElement
    throw UnimplementedError();
  }
}
