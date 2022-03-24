import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckbox.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';

import 'formable.dart';

class IFormCheckBoxGroup implements IForm {
  List<DrawCheckboxGroupItem> itemsList = [];

  dynamic _parameters;
  @override
  IDrawable drawFormElement() {
    print(_parameters);
    for (var checkBox in _parameters['values']) {
      var item = DrawCheckboxGroupItem(
        label: checkBox['label'],
        groupName: _parameters['name'],
        id: checkBox['value'],
      );
      itemsList.add(item);
    }

    if (_parameters['minMaxCheckbox'] == true)
      return DrawCheckboxGroup(
        label: _parameters['label'],
        required: _parameters['required'],
        showIfIsRequired: _parameters['showIfIsRequired'],
        showIfFieldValue: _parameters['showIfFieldValue'],
        showIfValueSelected: _parameters['showIfLogicCheckbox'],
        name: _parameters['name'],
        children: itemsList,
        minMaxCheckbox: _parameters['minMaxCheckbox'],
        maxCheckedAllowed: _parameters['checkboxMaxValue'],
        minCheckedAllowed: _parameters['checkboxMinValue'],
        isReadOnly: _parameters['isReadOnly'],
        visible:  _parameters['showIfLogicCheckbox'] == true  ? false : true,

        isHidden: _parameters['isHidden'],
        deactivated: _parameters['deactivate'],
        other:  false ,
      );
    return DrawCheckboxGroup(
      children: itemsList,
      minMaxCheckbox: _parameters['minMaxCheckbox'],
      label: _parameters['label'],
      required: _parameters['required'],
      showIfIsRequired: _parameters['showIfIsRequired'],
      showIfFieldValue: _parameters['showIfFieldValue'],
      showIfValueSelected: _parameters['showIfLogicCheckbox'],
      name: _parameters['name'],
      isReadOnly: _parameters['isReadOnly'],
      visible:  _parameters['showIfLogicCheckbox'] == true  ? false : true,

      isHidden: _parameters['isHidden'],
      deactivated: _parameters['deactivated'],other: _parameters['other'],
    );
  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;
  }
}
