import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckbox.dart';

import 'formable.dart';

class IFormCheckBoxGroup implements IForm{
  List<DrawCheckbox> itemsList =  [ ];

  dynamic _parametrs;
  @override
  Widget drawFormElement() {
    for(var checkBox in _parametrs['values']){
      var item = DrawCheckbox(label: checkBox['label'],);
      itemsList.add(item);
    }
    
    // TODO: implement drawFormElement
    return DrawCheckboxGroup(
      children: itemsList,
      label: _parametrs['label'],
    );
  }

  @override
  void setParameters(parametrs) {
    _parametrs = parametrs;
  }

}
