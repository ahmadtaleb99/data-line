

import 'package:form_builder_test/data/network/api_client.dart';

import 'app/dependency_injection.dart';

Future<void> main() async {

   final api = getIT<ApiClient>();
  await  api.getAssignedForms();
}


