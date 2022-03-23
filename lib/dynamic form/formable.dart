import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';

abstract class IForm {
  void setParameters(dynamic parametrs);

  IDrawable drawFormElement ();

}