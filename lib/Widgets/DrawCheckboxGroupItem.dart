import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:form_builder_test/logic/validation__bloc.dart';

class DrawCheckboxGroupItem extends StatelessWidget {
  DrawCheckboxGroupItem({
    Key? key,
    required this.label,
    this.validator,
    required this.id,
    required this.groupName,
    this.isChecked,
  }) : super(key: key);
  final String label;
  final String id;
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
            BlocBuilder<ValidationBloc, ValidationState>(
              buildWhen: (previous, current) {
                if (previous != current &&
                    current.drawCheckboxGroup != null &&  current.drawCheckboxGroup!.name == this.groupName) {
                  fieldState.validate();
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                return CheckboxListTile(
                  title:   Text(label),
                  value: isChecked ?? false,
                  onChanged: (value) {
                    debugPrint(this.groupName);
                    context.read<ValidationBloc>().add(CheckboxGroupValueChanged(
                        id: this.id,
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
}
