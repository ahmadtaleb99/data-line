import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

part 'CheckboxItem.g.dart';

@HiveType(typeId: 40)
class CheckboxItem implements IFormModel{

  @HiveField(1)
  String label;
  @HiveField(2)
  String groupName;
  @HiveField(3)
  dynamic value;
  CheckboxItem({
    required this.label,
    required this.groupName,
    required this.value,
  });

  factory CheckboxItem.FromJson(json,String groupName) {
    return CheckboxItem(
      label: json['label'],
      groupName: groupName,
      value:json['value'],
    );
  }


  @override
  FormElementWidget toWidget() {
    return DrawCheckboxGroupItem(label: label, value: value, groupName: groupName);
  }

  CheckboxItem copyWith({
    String? label,
    String? groupName,
    dynamic? value,
  }) {
    return CheckboxItem(
      label: label ?? this.label,
      groupName: groupName ?? this.groupName,
      value: value ?? this.value,
    );
  }


  @override
  String valueToString() {
    return this.value.toString();
  }
}