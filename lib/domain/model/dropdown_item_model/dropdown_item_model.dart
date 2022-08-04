import 'package:equatable/equatable.dart';

class DropDownItemModel extends Equatable{
  final String label;
  final String value;
  final String parent;
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
