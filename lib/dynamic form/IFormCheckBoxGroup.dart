import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckbox.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';

import 'formable.dart';

class IFormCheckBoxGroup implements IForm {
  List<DrawCheckboxGroupItem> itemsList = [];

  dynamic _parametrs;
  @override
  Widget drawFormElement() {
    for (var checkBox in _parametrs['values']) {
      var item = DrawCheckboxGroupItem(
        label: checkBox['label'],
      );
      itemsList.add(item);
    }

    if (_parametrs['minMaxCheckbox'] == true)
      return DrawCheckboxGroup(
        children: itemsList,
        label: _parametrs['label'],
        minMaxCheckbox: _parametrs['minMaxCheckbox'],
        maxCheckedAllowed: _parametrs['checkboxMaxValue'],
        minCheckedAllowed: _parametrs['checkboxMinValue'],
      );
    return DrawCheckboxGroup(
      children: itemsList,
      label: _parametrs['label'],
      minMaxCheckbox: _parametrs['minMaxCheckbox'],
    );
  }

  @override
  void setParameters(parametrs) {
    _parametrs = parametrs;
  }
}
