import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DropDownItemWidget  extends Equatable {
  final String  ? parent;
  final String  value;
  final String status;


  const DropDownItemWidget({
     this.parent,
    required this.value,
    required this.status,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [value,status,parent];




}
