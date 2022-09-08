import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'node.g.dart';
@HiveType(typeId: 32)
class Node extends Equatable{

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String name;

  @override
  List<Object?> get props => [id,name];

  const Node({
    required this.id,
    required this.name,
  });

  Node copyWith({
    String? id,
    String? name,
  }) {
    return Node(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}