import 'package:form_builder_test/Widgets/DrawRadioItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

part 'RadioItem.g.dart';


@HiveType(typeId: 56)
class RadioItem implements IFormModel  {

  @HiveField(1)
   String label;
  @HiveField(2)
  String parent;
  @HiveField(3)
  dynamic value;

  @override
  factory RadioItem.fromJson(parameters,String parent) {
    return RadioItem(

      label: parameters['label'],
      parent :parent,
      value: parameters['value']
    );
  }





   RadioItem({
    required this.label,
    required this.parent,
    required this.value,
  });

  @override
  Map<String, dynamic> fomrElementtoJson(FormElement formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
  }

  @override
  FormElement toWidget() {
    return DrawRadioItem(
        label: this.label,
        parent :this.parent,
        value: this.value,
    );
  }

  RadioItem copyWith({
    String? label,
    String? parent,
    dynamic? value,
  }) {
    return RadioItem(
      label: label ?? this.label,
      parent: parent ?? this.parent,
      value: value ?? this.value,
    );
  }
}
