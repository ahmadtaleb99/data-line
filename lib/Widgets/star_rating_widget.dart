import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_test/Widgets/form_field_widget.dart';
import '../validation/bloc/validation__bloc.dart';
import 'form_element_widget.dart';

class StarRatingWidget extends FormElementWidget {
  StarRatingWidget({
    Key? key,
    required this.label,
    required this.visible,
    required this.required,
    required this.name,
    this.value,
    required this.showIfValueSelected,
    required this.showIfFieldValue,
    required this.showIfIsRequired,
  }) : super(
            label: label,
            key: key,
            name: name,
            visible: visible,
            required: required,
            showIfValueSelected: showIfValueSelected,
            showIfFieldValue: showIfFieldValue,
            showIfIsRequired: showIfIsRequired);

  final String label;
  final String name;
  final bool required;
  dynamic value;
  bool? visible;

  final bool showIfValueSelected;
  final String? showIfFieldValue;
  final bool? showIfIsRequired;

  @override
  Widget build(BuildContext context) {
    print('value [$value] in text field class ');
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        StarRatingWidget stateField = state.form!.fields
                .firstWhere((element) => element.name == this.name)
            as StarRatingWidget;

        return FormFieldWidget<double>(
            visible: visible,
            required: required,
            validator: (rate) {
              if (required && this.value == null) {
                return 'required';
              }
            },
            widget: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 10),
                    child: Text(
                      '$label  ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Builder(builder: (context) {
                    return StarRatingBar(
                      name: name,
                      stateField: stateField,
                      value: value,
                      onValueChanged: (value) {
                        context
                            .read<ValidationBloc>()
                            .add(StarRatingUpdated(value: value, name: name));
                        log(value.toString());
                      },
                    );
                  }),
                ],
              ),
            ));
      },
    );
  }

  @override
  String valueToString() {
    return this.value.toString();
  }
}

class StarRatingBar extends StatelessWidget {
  StarRatingBar({
    Key? key,
    required this.name,
    required this.stateField,
    required this.value,
    required this.onValueChanged,
  }) : super(key: key);

  final String name;
  final StarRatingWidget stateField;
  final void Function(double) onValueChanged;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
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
        onValueChanged(currentRating);
      },
      child: RatingBarIndicator(
        rating: value ?? 0,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 50.0,
        direction: Axis.horizontal,
      ),
    );
  }
}
