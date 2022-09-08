import 'package:flutter/material.dart';
import 'package:datalines/domain/model/matrix_model/matrix_checkbox_model/matrix_checkbox_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_radio_group_model/matrix_radio_group_model.dart';
import 'package:datalines/presentation/form_widgets/matrix_widget/widgets/matrix_field_widget/matrix_field_widget.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
class MatrixRadioGroupWidget extends StatelessWidget {


final  MatrixRadioGroupModel model;
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
          children: [
            ...model.values
                .map((MultipleOptionsModel e) => RadioListTile<String>(

              value: e.value,
              onChanged: (isChecked) {
                context.read<FormsBloc>().add(MatrixFieldValueChanged(
                    fieldName: model.fieldName, value: isChecked));
              },
              title: Text(e.label),
              groupValue: context.read<FormsBloc>().getMatrixFieldValue(model.fieldName))
            )
                .toList(),

          ],
        );
  },
)
    );
  }

 const  MatrixRadioGroupWidget({
    required this.model,
  });
}
