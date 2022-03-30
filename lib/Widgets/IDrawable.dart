
import 'package:flutter/cupertino.dart';

abstract class FormElement extends StatelessWidget {

  final String label;
  final String name;
  final bool? required;
  bool ? visible;
  final bool ? showIfValueSelected;
  final String ? showIfFieldValue;
  final bool ? showIfIsRequired;


  FormElement({
  Key? key,
    required this.label,
    required this.name,
     this.visible,
     this.required,
     this.showIfValueSelected,
     this.showIfFieldValue,
     this.showIfIsRequired,
  }) : super(key: key) ;

}

