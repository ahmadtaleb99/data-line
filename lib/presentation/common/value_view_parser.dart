import 'package:form_builder_test/domain/model/matrix_model/matrix_record/matrix_record_model.dart';

class ValueViewParser{
 static String getValue (dynamic value){

   if(value == null )   return '';
    switch(value.runtimeType){


      case List<MatrixRecordModel>:
        return 'records: ${(value as List).length}';


      default:
        return value.toString();

    }
  }
}