import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:datalines/domain/model/number_text_field_model/number_text_field_model.dart';
import 'package:datalines/domain/model/star_rating_model/star_rating_model.dart';
import 'package:datalines/domain/model/text_field_model/text_field_model.dart';
import 'package:datalines/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/resources/color_manager.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({Key? key, required this.model})
      : super(key: key);
  final StarRatingModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return FormFieldWidget(
          validator: (value) {
            // return context.read<FormsBloc>().validateNumber(numberFieldModel,state.valuesMap[numberFieldModel.name]);
          }, widget: BlocBuilder<FormsBloc, FormsState>(
          builder: (context, state) {
            return _BuildStarRatingWidget(model: model,);
          },
        ), model: model,);
      },
    );
  }


}

class _BuildStarRatingWidget extends StatelessWidget {
  final StarRatingModel model;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Swiping in right direction.
            final box = context.findRenderObject() as RenderBox?;
            if (box == null) return;

            final _pos = box.globalToLocal(details.globalPosition);
            double i;
            i = num.parse((_pos.dx / 44).toStringAsFixed(1)).toDouble();
            var currentRating = i;
            if (currentRating > 5) {
              currentRating = 5.toDouble();
            }

            if (currentRating <= 0) {
              currentRating = 0;
            }
            context.read<FormsBloc>().add(
                FieldValueChanged(fieldName: model.name, value: currentRating));
          },
          child: RatingBarIndicator(
            rating: state.valuesMap[model.name] ?? 0,
            itemBuilder: (context, index) =>
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 50.0,
            direction: Axis.horizontal,
          ),
        );
      },
    );
  }

  const _BuildStarRatingWidget({
    required this.model,
     this.glowColor ,
  });
}
