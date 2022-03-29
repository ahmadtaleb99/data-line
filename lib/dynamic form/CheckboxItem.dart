import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';

class CheckboxItem implements IFormModel{
  String label;
  String groupName;
  String value;
  CheckboxItem({
    required this.label,
    required this.groupName,
    required this.value,
  });

  factory CheckboxItem.FromJson(parameters,String groupName) {
    return CheckboxItem(

      label: parameters['label'],
      groupName: groupName,
      value:parameters['value'],
    );
  }
  @override
  Map<String, dynamic> fomrElementtoJson(FormElement formElement) {
    return {};
  }

  @override
  FormElement getFormElement() {
    throw UnimplementedError();
  }


}