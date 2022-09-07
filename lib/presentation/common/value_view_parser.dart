class ValueViewParser{
 static String getValue (dynamic value){
    switch(value){

      case null:
      return '';

      default:
        return value.toString();

    }
  }
}