import 'package:flutter/material.dart' as radio_item_widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/Widgets/form_element_widget.dart';

import 'package:datalines/validation/bloc/validation__bloc.dart';

class RadioItemWidget extends FormElementWidget {
  final String value;
  final String parent;
  String? groupValue;


  final String label;

  final bool? showIfValueSelected;
  final String? showIfFieldValue;
  final bool? showIfIsRequired;
   radio_item_widget.Widget?    subTitle;
   radio_item_widget.Widget?    titleWidget;



  RadioItemWidget({
    radio_item_widget.Key? key,
    required this.label,
    this.showIfValueSelected,
    this.showIfFieldValue,
    this.showIfIsRequired,
    this.groupValue,
    required this.value,
    required this.parent, this.subTitle,
  }) : super(name: value,label: label);
  @override
  radio_item_widget.Widget build(radio_item_widget.BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return radio_item_widget.RadioListTile(
                contentPadding: radio_item_widget.EdgeInsets.all(5),
            value: value,
            title: titleWidget ?? radio_item_widget.Text(label),
            groupValue: groupValue,
            onChanged: (value) {
              print(value);
              context.read<ValidationBloc>().add(
                    RadioGroupValueChanged(
                      value: value.toString(),
                      groupName: this.parent,
                      id: this.value,
                    ),
                  );

            },
          subtitle:   subTitle  ,
            );
      },
    );
  }


  @override
  String valueToString() {
    return this.value.toString();
  }
}
