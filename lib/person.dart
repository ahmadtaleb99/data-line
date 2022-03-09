import 'package:hive/hive.dart';

part 'person.g.dart';


@HiveType(typeId: 1)
class Person extends HiveObject{



  @HiveField(1)
  final String name;

  @HiveField(2)
  final int age;

  @HiveField(3)
  final bool isMarried;

  Person({required this.name,required this.age,required this.isMarried});
}