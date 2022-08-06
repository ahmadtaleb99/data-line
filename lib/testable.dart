

import 'package:form_builder_test/data/network/api_client.dart';

import 'app/dependency_injection.dart';
import 'app/form_validation.dart';

Future<void> main() async {

   final person = Person ( );
   print((person is FormValidation).toString());
}


class Person with FormValidation {

}

