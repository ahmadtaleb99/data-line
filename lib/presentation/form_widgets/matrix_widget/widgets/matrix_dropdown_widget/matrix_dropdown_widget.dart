import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_dropdown_model/matrix_dropdown_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:form_builder_test/presentation/form_widgets/matrix_widget/widgets/matrix_field_widget/matrix_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/color_manager.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

class MatrixDropDownWidget extends StatelessWidget {


  MatrixDropDownModel model;
  @override
  Widget build(BuildContext context) {
    return MatrixFieldWidget(
        validator: (value) {
          // return context.read<FormsBloc>().validateNumber(numberFieldModel,state.valuesMap[numberFieldModel.name]);
        },
        model: model,
        widget: BlocBuilder<FormsBloc, FormsState>(
          builder: (context, state) {
            return Container(
                width: double.infinity,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: ColorManager.primary,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                        hint:Text( AppStrings.selectAValue),
                        value: context.read<FormsBloc>().getMatrixFieldValue(model.fieldName),
                        underline: Container(),
                        icon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Icon(Icons.arrow_drop_down),
                        ),
                        // items: hasItems()? [DropdownMenuItem<String>(child: Container(),)] :
                        items:
                        model.values.map((e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(e.label),
                        ))
                            .toList(),
                        onChanged: (String? newValue) {
                          // if(!hasItems()) return;
                          context.read<FormsBloc>().add(MatrixFieldValueChanged(
                              fieldName: model.fieldName, value: newValue));
                        },
                      ),
                    )));
          },
        )
    );

  }

  MatrixDropDownWidget({
    required this.model,
  });
}
