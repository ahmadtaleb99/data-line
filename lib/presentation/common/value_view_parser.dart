import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:datalines/domain/model/matrix_model/matrix_record/matrix_record_model.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';

class ValueViewParser{
 static String getValue (dynamic value){

   if(value == null )   return '';


    switch(value.runtimeType){

      case String:
      if(isDate(value)){
        return DateFormat('d - MMMM - y').format(DateTime.parse(value));
      }
      else return value;


      case List<MatrixRecordModel>:
        return '${AppStrings.records}: ${(value as List).length}';


      default:
        return value.toString();

    }
  }
}

bool isDate (String value) =>  DateTime.tryParse(value) != null;
