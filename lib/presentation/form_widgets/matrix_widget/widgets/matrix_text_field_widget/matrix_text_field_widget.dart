import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_text_field_model/matrix_text_field_model.dart';
import 'package:form_builder_test/presentation/form_widgets/matrix_widget/widgets/matrix_field_widget/matrix_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';

class MatrixTextFieldWidget extends StatelessWidget {


  MatrixTextFieldModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return MatrixFieldWidget(
          validator: (value) {
            // return context.read<FormsBloc>().validateNumber(numberFieldModel,state.valuesMap[numberFieldModel.name]);
          }, widget: TextFormField(
          key: UniqueKey(),
          autovalidateMode  : AutovalidateMode.onUserInteraction,
          initialValue: context.read<FormsBloc>().getMatrixFieldValue(model.fieldName),
          onChanged: (text) {
            context.read<FormsBloc>().add(MatrixTextValueChanged(
                fieldName: model.fieldName, value: text));
          },
        ), model: model,);
      },
    );

  }

  MatrixTextFieldWidget({
    required this.model,
  });
}
