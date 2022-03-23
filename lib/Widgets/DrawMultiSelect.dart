import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'DrawChildList.dart';
import 'DropDownItemWidget.dart';

class DrawMultiSelect extends IDrawable {
  DrawMultiSelect( {Key? key,
    this.visible = false,
    required this.label,
    required this.showIfIsRequired,
    required this.deactivated,
    required this.required,
    required this.relatedToParent,
    required this.isHidden,
    required this.isReadOnly,
    required this.prompt,
    required this.items,
    required this.multiple,
     this.selectedValues,
    required this.showIfValueSelected,
    required this.showIfFieldValue,
    this.parentName,
    required this.name,
    this.validator})
      : super(
      key: key,
      label: label,
      name: name,
      visible: visible,
      required: required,
      showIfValueSelected: showIfValueSelected,
      showIfFieldValue: showIfFieldValue,
      showIfIsRequired: showIfIsRequired);

  String? value;
  final String label;
  final bool deactivated;
  final bool required;
  final bool isHidden;
  final bool multiple;
  bool ? visible;
  List<String> ? selectedValues;
  final bool isReadOnly;
  final bool relatedToParent;
  final bool? showIfIsRequired;
  final bool showIfValueSelected;
  final String? showIfFieldValue;

  final String prompt;
  final String name;
  final String? parentName;
  final String? Function(dynamic)? validator;

  List<DropDownItemWidget> items;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(

      builder: (context, state) {
      print('1 ${state.formElements?.first.name}');
      print('2 ${this.parentName}');
        // var parentList = state.formElements!.firstWhere((element) => element.name == this.parentName);
        // String parentListLabel = parentList.label;
        DrawMultiSelect? list;
      List<DropDownItemWidget> itemsToBuild;
      if(!relatedToParent) {
        print('fat1q $name');
        itemsToBuild = this.items;
        print(this.items);
        print('test passed ');
      }
      else {
        print('fat2 $name');
          if (state.childsMap != null && state.childsMap.isNotEmpty) {
            list = state.childsMap[this.name] as DrawMultiSelect;
            itemsToBuild = list.items;
          } else
            itemsToBuild = [];
        }

        return FormField<dynamic>(
            validator: (value) {
              if (this.selectedValues == null   )
                return 'required';
              else
                return null;
            },
            builder: (FormFieldState<dynamic> fieldState) =>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 10),
                      child: Text(''
                        // '$label - ${list == null ? ' ${parentListLabel}' : list.items.first.parent} '
                        // ,style: TextStyle(fontSize: 18),
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
                            child: MultiSelectDialogField<String>(

                              dialogHeight: list != null ? null : 5 ,
                              dialogWidth:  list != null ? null : 5,
                              chipDisplay: MultiSelectChipDisplay.none(),
                              selectedItemsTextStyle: TextStyle(color: Colors.black),
                              buttonIcon: Icon(Icons.arrow_drop_down),
                              decoration: BoxDecoration(),
                              title:  list != null ? Text(label) : Text('Please Select a '),
                              buttonText: Text(prompt),
                              listType: MultiSelectListType.CHIP,

                              // items: relatedToParent && items.isEmpty ?  _buildItemsMulti([]) :  _buildItemsMulti(items!) ,
                              items: _buildItemsMulti(this.items) ,
                              initialValue: [],
                              onConfirm: (values) {
                                selectedValues = values;
                               context.read<ValidationBloc>().add(childDropDownChanged(childList: this, value: ''));
                              },
                            )
                          ),
                        ),
                      ),
                    ),
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


  List<MultiSelectItem<String>> _buildItemsMulti(

      List<DropDownItemWidget> items) {
    List<MultiSelectItem<String>> list = [];
    if (items.isEmpty)
    {
      return [];
    }
    print('iteemsss to draw  ${items.toString()}');
    for (var item in items) {
      list.add(MultiSelectItem(item.value, item.value));
    }
    return list;
  }

  DrawMultiSelect copyWith({
    String? value,
    String? label,
    bool? deactivated,
    bool? required,
    bool? isHidden,
    bool? multiple,
    bool? visible,
    bool? isReadOnly,
    bool? relatedToParent,
    bool? showIfIsRequired,
    bool? showIfValueSelected,
    String? showIfFieldValue,
    String? prompt,
    String? name,
    String? parentName,
    String? Function(dynamic)? validator,
    List<DropDownItemWidget>? items,
    List<MultiSelectItem<String>>? list,
  }) {
    return DrawMultiSelect(
      label: label ?? this.label,
      deactivated: deactivated ?? this.deactivated,
      required: required ?? this.required,
      isHidden: isHidden ?? this.isHidden,
      multiple: multiple ?? this.multiple,
      visible: visible ?? this.visible,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      relatedToParent: relatedToParent ?? this.relatedToParent,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      showIfValueSelected: showIfValueSelected ?? this.showIfValueSelected,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      prompt: prompt ?? this.prompt,
      name: name ?? this.name,
      parentName: parentName ?? this.parentName,
      validator: validator ?? this.validator,
      items: items ?? this.items,
    );
  }
}
