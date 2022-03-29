import 'package:form_builder_test/Widgets/DrawRadioItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel';

class RadioItem  {
   String label;
   String parent;
   String value;

  @override
  factory RadioItem.fromJson(parameters,String parent) {
    return RadioItem(

      label: parameters['label'],
      parent :parent,
      value: parameters['value']
    );
  }



   DrawRadioItem formElementFromJson() {
     return DrawRadioItem(
         label: this.label,
         parent :this.parent,
         value: this.value
     );
   }

   RadioItem({
    required this.label,
    required this.parent,
    required this.value,
  });
}
