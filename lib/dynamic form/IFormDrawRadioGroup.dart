import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawRadioGroup.dart';
import 'package:form_builder_test/Widgets/DrawRadioItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';

import 'formable.dart';

class IFormDrawRadioGroup implements IFormModel{

  dynamic _parameters;

  @override
  FormElement formElementFromJson() {
    List<DrawRadioItem> children = [];
    for (var radio in _parameters['values']){
      var newRadio = DrawRadioItem(label: radio['label'], value: radio['value'], parent:_parameters['name'],hasOther: false,);
      children.add(newRadio);

    }
    if(_parameters['other']==true) children.add(   DrawRadioItem(label: 'other', value: 'other',
        parent: _parameters['name'],
    hasOther:  true,
    ),
    );

    return DrawRadioGroup(label: _parameters['label'], name: _parameters['name'],
       required: _parameters['required'], other: _parameters['other'],
        showIfValueSelected: false,

        showIfIsRequired: _parameters['showIfIsRequired'],
        showIfFieldValue: _parameters['showIfFieldValue'],
        children: children);

  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;

  }

  @override
  Map<String, dynamic> fomrElementtoJson(FormElement formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
  }


}