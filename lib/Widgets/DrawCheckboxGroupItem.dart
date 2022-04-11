import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';

import 'package:form_builder_test/logic/validation__bloc.dart';

class DrawCheckboxGroupItem extends FormElement {
  DrawCheckboxGroupItem({
    Key? key,
    required this.label,
    this.validator,
    required this.value,
    required this.groupName,
    this.isChecked,
  }) : super(key: key,label: label , name: value);
  final String label;
  final String value;
  final String groupName;
  final String? Function(bool?)? validator;
  bool? isChecked;

  @override
  Widget build(BuildContext context) {
    bool? _value = false;
    return FormField<bool>(

      validator: validator,
      builder: (FormFieldState<bool> fieldState) {
        return Column(

          children: [
            BlocConsumer<ValidationBloc, ValidationState>(
              // buildWhen: (previous, current) {
              //   if (previous != current &&
              //       current.drawCheckboxGroup != null &&  current.drawCheckboxGroup!.name == this.groupName) {
              //     fieldState.validate();
              //     return true;
              //   }
              //   return false;
              // },
              listener: (context,state){
                fieldState.validate();

              },
              builder: (context, state) {
                return CheckboxListTile(
                  title:   Text(label),
                  value: isChecked ?? false,
                  onChanged: (value) {
                    debugPrint(this.groupName);
                    context.read<ValidationBloc>().add(CheckboxGroupValueChanged(
                        id: this.value,
                        value: this.value,
                        newIsChecked: value!,
                        groupName: this.groupName));


                  },
                );

                return Checkbox(
                  value: isChecked ?? false,
                  onChanged: (value) {
                    debugPrint(this.groupName);
                    isChecked = value;
                  },
                );
              },
            ),
            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 10),
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
        );
      },
    );
  }


  @override
  String valueToString() {
    return this.value.toString();
  }
}
