import 'package:form_builder_test/Widgets/IDrawable.dart';

abstract class FormApi {

  List<FormElement> getFormElements();

  void saveFormElements();


}