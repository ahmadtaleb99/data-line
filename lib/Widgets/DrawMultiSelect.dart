import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/testable.dart';

import 'DropDownItemWidget.dart';

class DrawMultiSelect extends IDrawable{



  final String label;
  final bool deactivated;
  final bool required;
  final bool isHidden;
  bool visible;
  final bool isReadOnly;
  final bool? showIfIsRequired;
  final  bool  showIfValueSelected;
  final String? showIfFieldValue;

  String? value;
  final String prompt;
  final String name;
  final String? parentName;
  final bool relatedToParent;
  final String? Function(dynamic)? validator;
  List<DropDownItemWidget> items;


  DrawMultiSelect(
      {Key? key,
        required this.label,
        required this.showIfIsRequired,
        required this.deactivated,
        required this.required,
        required this.isHidden,
        required this.isReadOnly,
        required this.prompt,
        required  this.showIfValueSelected,
        required  this.showIfFieldValue,
        this.visible = false,
        required this.items,
        required this.relatedToParent,
        this.parentName,
        required this.name,
        this.validator})

      : super(key: key,label: label,
      visible: visible, required: required,
      showIfValueSelected: showIfValueSelected,
      showIfFieldValue: showIfFieldValue,
      showIfIsRequired: showIfIsRequired);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return FormField<dynamic>(
            validator: (value) {
              if(this.value == null ) {
                return 'required';
              } else return null;
            },
            builder: (FormFieldState<dynamic> fieldState) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 10),
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.black38,
                              width: 3), //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              50), //border raiuds of dropdown button
                          boxShadow: <BoxShadow>[
                            //apply shadow on Dropdown button
                            BoxShadow(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.57), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Center(
                          child: DropdownButton<dynamic>(

                              onTap: () {
                                FocusScopeNode currentFocus = FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              underline: Container(),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 99),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                              hint: Text(prompt),
                              disabledHint: Text(prompt),
                              value: value ?? null,
                              items: _buildItems(items),
                              onChanged: (value) {

                              }),
                        ),
                      ),
                    )),
                if (fieldState.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 15),
                    child: Text(
                      fieldState.errorText!,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 13,
                          color: Colors.red[700],
                          height: 0.5),
                    ),
                  )
              ],
            ));
      },
    );
  }
}

List<DropdownMenuItem<dynamic>>? _buildItems(List<DropDownItemWidget> items) {
  List<DropdownMenuItem<dynamic>>? list = [];

  print('iteemsss to draw  ${items.toString()}');
  for (var item in items) {
    list.add(DropdownMenuItem(
      child: Text(item.value),
      value: item.value,
    ));
  }
  return list;
}
