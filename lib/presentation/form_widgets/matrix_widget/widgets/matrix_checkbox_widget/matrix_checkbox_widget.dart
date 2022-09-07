import 'package:flutter/material.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_checkbox_model/matrix_checkbox_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/presentation/form_widgets/matrix_widget/widgets/matrix_field_widget/matrix_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';

class MatrixCheckboxWidget extends StatelessWidget {
  final MatrixCheckboxModel model;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return MatrixFieldWidget(
            showLabel: false,
            validator: (value) {
              // return context.read<FormsBloc>().validateNumber(numberFieldModel,state.valuesMap[numberFieldModel.name]);
            },
            model: model,
            widget: CheckboxListTile(
              title: Text(model.label),
              onChanged: (isChecked) {
                context.read<FormsBloc>().add(MatrixFieldValueChanged(
                    fieldName: model.fieldName, value: isChecked));
              },
              value: context.read<FormsBloc>().getMatrixFieldValue(model.fieldName) ?? false,
            ));
      },
    );
  }

  const MatrixCheckboxWidget({
    required this.model,
  });
}
