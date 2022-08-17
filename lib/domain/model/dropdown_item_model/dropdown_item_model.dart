import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'dropdown_item_model.g.dart';


@immutable
@HiveType(typeId: 3)
class DropDownItemModel extends Equatable{
  @HiveField(1)
  final String label;

  @HiveField(2)
  final String value;

  @HiveField(3)
  final String parent;

  @HiveField(4)
  final String status;

  const DropDownItemModel({
    required this.label,
    required this.value,
    required this.parent,
    required this.status,
  });
  @override
  List<Object?> get props => [label,value,parent,status];

  DropDownItemModel copyWith({
    String? label,
    String? value,
    String? parent,
    String? status,
  }) {
    return DropDownItemModel(
      label: label ?? this.label,
      value: value ?? this.value,
      parent: parent ?? this.parent,
      status: status ?? this.status,
    );
  }
}
