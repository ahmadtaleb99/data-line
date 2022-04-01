import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:hive/hive.dart';

part 'IFormModel.g.dart';
@HiveType(typeId: 27)
abstract class IFormModel {

  FormElement toWidget ();
  Map<String,dynamic> fomrElementtoJson (FormElement formElement);


}