import 'package:hive/hive.dart';

import '../../data/responses/forms/enums.dart';
import '../../model/FileTypeEnum.dart';


part 'Expression.g.dart';

@HiveType(typeId: 61)
class Expression {
  @HiveField(1)
  final Operator operator;
  @HiveField(2)
  final int value;
  @HiveField(3)
  final int? value2;

  Expression( {required this.operator,required  this.value,this.value2});




}




final OperatorsValues = EnumValues(
    {
      "more": Operator.MORE,
      "less": Operator.LESS,
      "equal": Operator.EQUAL,
      "between": Operator.BETWEEN,

    }
);

final fileTypeEnumValues = EnumValues(
    {
      "Image": FileTypeEnum.IMAGE,
      "Audio": FileTypeEnum.AUDIO,
      "Video": FileTypeEnum.VIDEO,
      "Text": FileTypeEnum.TEXT

    }
);

class EnumValues<T> {
  Map<String, T> ? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}



