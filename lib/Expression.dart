import 'Widgets/DrawNumberField.dart';
import 'dynamic form/FileTypeEnum.dart';
class Expression {
  final Operator operator;
  final int value;
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

enum Operator {MORE,LESS,EQUAL,BETWEEN}



