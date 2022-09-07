import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/form_validation.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_number_model/matrix_number_model.dart';
import 'package:form_builder_test/presentation/form_widgets/matrix_widget/widgets/matrix_field_widget/matrix_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

class MatrixNumberWidget extends StatelessWidget with FormValidation{


  MatrixNumberModel model;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return MatrixFieldWidget(
          validator: (value) {
          }, widget: TextFormField(
          key: UniqueKey(),
          autovalidateMode  : AutovalidateMode.onUserInteraction,
          initialValue: context.read<FormsBloc>().getMatrixFieldValue(model.fieldName),
          onChanged: (text) {
            context.read<FormsBloc>().add(MatrixTextValueChanged(
                fieldName: model.fieldName, value: text));
          },
          validator: (value){
           if(value != null )
             return isNumeric(value.toString()) ? null : AppStrings.mustBeANumber;

          },
        ), model: model,);
      },
    );

  }

  MatrixNumberWidget({
    required this.model,
  });
}
