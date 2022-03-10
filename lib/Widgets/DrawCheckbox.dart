import 'package:flutter/material.dart';

class DrawCheckbox extends StatelessWidget {
  const DrawCheckbox({Key? key, required this.label, this.validator}) : super(key: key);
  final String label;
  final String? Function(bool?)? validator;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        FormField<bool>(
          validator: validator,
          builder: (FormFieldState<bool> fieldState) {

            return Column(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
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
            )],
            );
          },
        )
      ],
    );
  }
}
