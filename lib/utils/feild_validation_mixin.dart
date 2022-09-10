import 'package:datalines/data/responses/forms/enums.dart';

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





  String? validateTextArea(String text,int minText,int maxText) {


      if(text.length < minText || text.length > maxText ){
        return 'must be between $minText and $maxText character';
      }

      else return null;
    }





}