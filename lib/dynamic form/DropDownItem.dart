import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';


part 'DropDownItem.g.dart';
@HiveType(typeId: 41)

class DropDownItem  extends  IFormModel with EquatableMixin{

  @HiveField(1)
  final String? parent;

  @HiveField(2)
   dynamic value;

  @HiveField(3)
  final String status;


  factory DropDownItem.fromJson(json) {
    return DropDownItem(
        value: json['value'], status: json['status'] ?? '', parent: json['parent'] ?? '');
  }

   DropDownItem({
    this.parent,
    required this.value,
    required this.status,
   }) : super( name: value,label: value) ;


  // @override
  // // TODO: implement props
  // List<Object?> get props => [value, status, parent];

  @override
  Map<String, dynamic> fomrElementtoJson(formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
  }

  @override
  FormElementWidget toWidget() {
    // TODO: implement getFormElement
    throw UnimplementedError();
  }

  DropDownItem copyWith({
    String? parent,
    dynamic? value,
    String? status,
  }) {
    return DropDownItem(
      parent: parent ?? this.parent,
      value: value ?? this.value,
      status: status ?? this.status,
    );
  }

  @override
  String valueToString() {
    return this.value.toString();
  }
  @override
  bool isValid() {
    // TODO: implement isValid
    throw UnimplementedError();
  }
  @override
  // TODO: implement props
  List<Object?> get props => [parent,value,status];
}
