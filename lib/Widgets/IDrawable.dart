
import 'package:flutter/cupertino.dart';

abstract class IDrawable extends StatelessWidget {

  final String label;
  final String name;
  final bool required;
  bool visible;
  final bool showIfValueSelected;
  final String ? showIfFieldValue;
  final bool ? showIfIsRequired;


  IDrawable({
  Key? key,
    required this.label,
    required this.name,
    required this.visible,
    required this.required,
    required this.showIfValueSelected,
    required this.showIfFieldValue,
    required this.showIfIsRequired,
  }) : super(key: key) ;

}

