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
    return FormField<bool>(
      validator: (value ){
        if(minMaxCheckbox == true ){
         if(checksNumber > maxCheckedAllowed! || checksNumber < minCheckedAllowed!){
           return 'you must check between $minCheckedAllowed and $maxCheckedAllowed at least number if checks ::$checksNumber';
         }
        }
        else return null;

      },
      builder: (FormFieldState<bool> fieldState){
        return      Column(
          children: [
            Text(label),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<ValidationBloc, ValidationState>(
              builder: (context, state) {
                var children;
                if(state.drawCheckboxGroup != null && state.drawCheckboxGroup!.name == this.name)
                  children = state.drawCheckboxGroup?.children ;
                return Column(children:  children ?? this.children);
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
