import 'package:equatable/equatable.dart';

class Node extends Equatable{
 final String id;
 final String name;

  const Node({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id,name];

 Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory Node.fromJson(Map<String, dynamic> map) {
    return Node(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}