import 'package:flutter/material.dart';
import 'package:datalines/domain/model/matrix_model/matrix_checkbox_group_model/matrix_checkbox_group_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:datalines/presentation/form_widgets/matrix_widget/widgets/matrix_field_widget/matrix_field_widget.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';


class MatrixCheckboxGroupWidget extends StatelessWidget {

  MatrixCheckboxGroupModel model;
  @override
  Widget build(BuildContext context) {
    return MatrixFieldWidget(
        validator: (value) {
          // return context.read<FormsBloc>().validateNumber(numberFieldModel,state.valuesMap[numberFieldModel.name]);
        },
        model: model,
        widget: BlocBuilder<FormsBloc, FormsState>(
          builder: (context, state) {
            return Column(
              children: model.values
                  .map((MultipleOptionsModel e) => CheckboxListTile(
                value: getValue(context.read<FormsBloc>().getMatrixFieldValue(model.fieldName), e.value),
                onChanged: (isChecked) {

                      context.read<FormsBloc>().add(MatrixCheckboxGroupValueChanged(
                          fieldName: model.fieldName, isChecked: isChecked!,value: e.value));

                },
                title: Text(e.label),
              ))
                  .toList(),
            );
          },
        )
    );
  }


  bool getValue(List? list, String value) {
    if (list == null) return false;
    return list.contains(value) ? true : false;
  }

  MatrixCheckboxGroupWidget({
    required this.model,
  });
}
