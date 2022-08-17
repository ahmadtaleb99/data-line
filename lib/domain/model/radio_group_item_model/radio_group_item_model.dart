import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'radio_group_item_model.g.dart';

@HiveType(typeId: 8)
class RadioGroupItemModel extends Equatable{
  @HiveField(1)
  final String label;

  @HiveField(2)
  final String value;

  @HiveField(3)
  final String parent;

  @HiveField(4)
  final String status;

  const RadioGroupItemModel({
    required this.label,
    required this.value,
    required this.parent,
    required this.status,
  });

  @override
  List<Object?> get props => [label,value,parent,status];

  RadioGroupItemModel copyWith({
    String? label,
    String? value,
    String? parent,
    String? status,
  }) {
    return RadioGroupItemModel(
      label: label ?? this.label,
      value: value ?? this.value,
      parent: parent ?? this.parent,
      status: status ?? this.status,
    );
  }
}
