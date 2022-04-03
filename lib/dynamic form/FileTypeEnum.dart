
import 'package:hive/hive.dart';
part 'FileTypeEnum.g.dart';
@HiveType(typeId: 57)
enum FileTypeEnum {
  @HiveField(1)
  IMAGE,
@HiveField(2)
  TEXT,
@HiveField(3)
  VIDEO,
@HiveField(4)
  AUDIO}
