import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'dropdown_item_model.g.dart';

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
}
