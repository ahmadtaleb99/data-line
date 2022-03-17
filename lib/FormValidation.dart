import 'package:form_builder_test/Expression.dart';
import 'package:form_builder_test/Widgets/DrawNumberField.dart';

mixin FormValidation{

  bool isValidEmail(String email){

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  bool isValidUser(String userName){

    Pattern pattern =
        r"^[a-zA-Z]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$";
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(userName);
  }


  bool isValidPassword(String password){

    Pattern pattern =
        r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(password);
  }







  String? validateNumber(int number,Expression expression) {


      switch(expression.operator){
        case Operators.BETWEEN:
          if(number >= expression.value && number <= expression.value2!){
            return null;
          }
          else return 'number must be between  ${expression.value} and  ${expression.value2}';
        case Operators.LESS:
          return  number < expression.value ? null : 'number should be less than ${expression.value}';
        case Operators.MORE:
          return  number > expression.value ? null : 'number should be more than ${expression.value}';
        case Operators.EQUAL:
          return  number != expression.value ? null : 'number should be equal to ${expression.value}';
      }




  }


}