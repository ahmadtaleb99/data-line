import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:datalines/presentation/form_widgets/star_rating_widget/star_rating_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/responses/forms/forms_response.dart';
import '../../../data/responses/forms/enums.dart';
import '../form_model.dart';


part 'star_rating_model.g.dart';

@HiveType(typeId: 10)
class StarRatingModel extends FormFieldModel with EquatableMixin{
  StarRatingModel({
    required String name,
    required String label,
    required String showIfFieldName,
    required String showIfFieldValue,
    required FieldType type,
    required bool deactivate,
    required bool required,
    required bool isHidden,
    required bool isReadOnly,
    required bool showIfLogicCheckbox,
    required bool showIfIsRequired,
    required bool requiredIfLogicCheckbox,
  }) : super(
      name: name,
      label: label,
      type: type,
      deactivate: deactivate,
      required: required,
      showIfFieldValue: showIfFieldValue,
      showIfFieldName: showIfFieldName,
      isHidden: isHidden,
      isReadOnly: isReadOnly,
      showIfLogicCheckbox: showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired,
      requiredIfLogicCheckbox: requiredIfLogicCheckbox);

  StarRatingModel copyWith({

    String? name,
    String? label,
    String? showIfFieldName,
    String? showIfFieldValue,
    FieldType? type,
    bool? deactivate,
    bool? required,
    bool? isHidden,
    bool? isReadOnly,
    bool? showIfLogicCheckbox,
    bool? showIfIsRequired,
    bool? requiredIfLogicCheckbox,
  }) {
    return StarRatingModel(

      name: name ?? this.name,
      label: label ?? this.label,
      type: type ?? this.type,
      deactivate: deactivate ?? this.deactivate,
      required: required ?? this.required,
      isHidden: isHidden ?? this.isHidden,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      showIfLogicCheckbox: showIfLogicCheckbox ?? this.showIfLogicCheckbox,
      showIfFieldName: showIfFieldName ?? this.showIfFieldName,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      requiredIfLogicCheckbox:
      requiredIfLogicCheckbox ?? this.requiredIfLogicCheckbox,

    );
  }

  @override

  List<Object?> get props => super.props;

  @override
  Widget toWidget() {
    return StarRatingWidget(model: this);
  }
}
