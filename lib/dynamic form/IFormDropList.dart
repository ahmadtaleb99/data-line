import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/dynamic%20form/formable.dart';

class IFormDropList implements IForm {
  dynamic _parameters;
  List<DropdownMenuItem> itemsList =  [ ];

  @override
  Widget drawFormElement({parameters}) {
    for(var menuItem in _parameters['values']){
      DropdownMenuItem item = DropdownMenuItem(value: Text(menuItem['value']),child: Text(menuItem['value']),);
      itemsList.add(item);
    }
    return DrawDropDownButton(
        label: _parameters['label'],
        deactivated: _parameters['deactivate'],
        reqired: _parameters['required'],
        isHidden: _parameters['isHidden'],
        isReadOnly: _parameters['isReadOnly'],
        prompt: _parameters['prompt'], items: itemsList, relatedToParent: _parameters['relatedListCheckbox'],
     parentName :  _parameters['relatedListFieldName'] ?? null,);
  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;
  }
}
