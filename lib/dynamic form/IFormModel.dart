import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';

abstract class IFormModel {
  FormElement getFormElement ();
  Map<String,dynamic> fomrElementtoJson (FormElement formElement);

}