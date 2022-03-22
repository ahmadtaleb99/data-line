import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';

class DrawCheckboxGroup extends StatelessWidget {
  DrawCheckboxGroup({Key? key,
    required this.children,
    required this.label,
    required this.minMaxCheckbox,
    this.minCheckedAllowed,
    this.maxCheckedAllowed, required this.name, this.validator})


      : super(key: key);
  final List<DrawCheckboxGroupItem> children;
  final String label;
  final String name;
  final bool minMaxCheckbox;
  final int? minCheckedAllowed;
  final int? maxCheckedAllowed;
  final String? Function(bool?)? validator;
  int checksNumber = 0;

  @override
  Widget build(BuildContext context) {
    return  FormField<bool>(

          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (minMaxCheckbox == true) {
              if (checksNumber > maxCheckedAllowed! ||
                  checksNumber < minCheckedAllowed!) {
                return 'you must choose at least  $minCheckedAllowed and no more than $maxCheckedAllowed';
              }
            }
            else
              return null;
          },
          builder: (FormFieldState<bool> fieldState) {
            return GestureDetector(
                onTap: () =>  fieldState.validate(),
              child: Column(
                children: [
                  Text(label),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<ValidationBloc, ValidationState>(
                    buildWhen: (previous, current) {
                   if(previous != current && current.drawCheckboxGroup!.name == this.name){
                     fieldState.validate();
                          return true;

                   }
                   return false;
                    },
                    builder: (context, state) {

                      print('state');
                      var children;
                      if (state.drawCheckboxGroup != null &&
                          state.drawCheckboxGroup!.name == this.name) {
                        {
                          children = state.drawCheckboxGroup?.children;

                        }
                      }

                      return GestureDetector(onTap: () => fieldState.validate() ,child: Column(children: children ?? this.children));

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

              ),
            );
          },

        );

  }
}
