import 'Widgets/DrawNumberField.dart';
class Expression {
  final Operators operator;
  final int value;
  final int? value2;

  Expression( {required this.operator,required  this.value,this.value2});




}




final OperatorsValues = EnumValues(
    {
      "more": Operators.MORE,
      "less": Operators.LESS,
      "equal": Operators.EQUAL,
      "between": Operators.BETWEEN,

    }
);

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

enum Operators {MORE,LESS,EQUAL,BETWEEN}
