import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/Widgets/DropDownItemWidget.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/formable.dart';

class IFormDropList implements IForm {
  dynamic _parameters;
  List<DropDownItemWidget> itemsList = [];

  @override
  IDrawable drawFormElement({parameters}) {
    for (var menuItem in _parameters['values']) {
      DropDownItemWidget item = DropDownItemWidget(
          parent: menuItem['parent'],
          value: menuItem['value'],
          status: menuItem['status']);
      itemsList.add(item);
    }
    if (_parameters['relatedListCheckbox']) {
      return DrawChildList(
          label: _parameters['label'],
          deactivated: _parameters['deactivate'],
          required: _parameters['required'],
          isHidden: _parameters['isHidden'],
          name: _parameters['name'],
          isReadOnly: _parameters['isReadOnly'],
          prompt: _parameters['prompt'],
          items: itemsList,
          parentName: _parameters['relatedListFieldName'],   showIfIsRequired: _parameters['showIfIsRequired'],
        showIfFieldValue: _parameters['showIfFieldValue'],
        showIfValueSelected: _parameters['showIfLogicCheckbox'], multiple: _parameters['multiple']);
    } else
      return DrawDropDownButton(
        name: _parameters['name'],
        isReadOnly: _parameters['isReadOnly'],
        prompt: _parameters['prompt'],
        items: itemsList,
        relatedToParent: _parameters['relatedListCheckbox'],
        parentName: _parameters['relatedListFieldName'] ?? null,


        label: _parameters['label'],
        deactivated: _parameters['deactivate'],
        required: _parameters['required'],
        isHidden: _parameters['isHidden'],
        showIfIsRequired: _parameters['showIfIsRequired'],
        showIfFieldValue: _parameters['showIfFieldValue'],
        showIfValueSelected: _parameters['showIfLogicCheckbox'], multiple: _parameters['multiple'],
      );
  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;
  }
}
