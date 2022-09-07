import 'package:form_builder_test/domain/model/matrix_model/matrix_record/matrix_record_model.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

class ValueViewParser{
 static String getValue (dynamic value){

   if(value == null )   return '';
    switch(value.runtimeType){


      case List<MatrixRecordModel>:
        return '${AppStrings.records}: ${(value as List).length}';


      default:
        return value.toString();

    }
  }
}