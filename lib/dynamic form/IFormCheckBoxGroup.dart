import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckbox.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';

import 'formable.dart';

class IFormCheckBoxGroup implements IForm {
  List<DrawCheckboxGroupItem> itemsList = [];

  dynamic _parametrs;
  @override
  IDrawable drawFormElement() {
    print(_parametrs);
    for (var checkBox in _parametrs['values']) {
      var item = DrawCheckboxGroupItem(
        label: checkBox['label'],
        groupName: _parametrs['name'],
        id: checkBox['value'],
      );
      itemsList.add(item);
    }

    if (_parametrs['minMaxCheckbox'] == true)
      return DrawCheckboxGroup(
        label: _parametrs['label'],
        required: _parametrs['required'],
        showIfIsRequired: _parametrs['showIfIsRequired'],
        showIfFieldValue: _parametrs['showIfFieldValue'],
        showIfValueSelected: _parametrs['showIfLogicCheckbox'],
        name: _parametrs['name'],
        children: itemsList,
        minMaxCheckbox: _parametrs['minMaxCheckbox'],
        maxCheckedAllowed: _parametrs['checkboxMaxValue'],
        minCheckedAllowed: _parametrs['checkboxMinValue'],
        isReadOnly: _parametrs['isReadOnly'],
        isHidden: _parametrs['isHidden'],
        deactivated: _parametrs['deactivated'], other: _parametrs['other'],
      );
    return DrawCheckboxGroup(
      children: itemsList,
      minMaxCheckbox: _parametrs['minMaxCheckbox'],
      label: _parametrs['label'],
      required: _parametrs['required'],
      showIfIsRequired: _parametrs['showIfIsRequired'],
      showIfFieldValue: _parametrs['showIfFieldValue'],
      showIfValueSelected: _parametrs['showIfLogicCheckbox'],
      name: _parametrs['name'],
      isReadOnly: _parametrs['isReadOnly'],
      isHidden: _parametrs['isHidden'],
      deactivated: _parametrs['deactivated'],other: _parametrs['other'],
    );
  }

  @override
  void setParameters(parametrs) {
    _parametrs = parametrs;
  }
}
