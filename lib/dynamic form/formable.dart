import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';

abstract class IFormModel {
  void setParameters(dynamic parametrs);

  FormElement formElementFromJson ();
  Map<String,dynamic> fomrElementtoJson (FormElement formElement);

}