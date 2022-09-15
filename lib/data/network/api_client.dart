import 'dart:convert';
import 'dart:developer';

import 'package:datalines/data/network/api_constants.dart';
import 'package:datalines/data/network/dio_factory.dart';
import 'package:datalines/data/requests/forms/form_sync_request.dart';
import 'package:datalines/data/responses/forms/forms_response.dart';
import 'package:datalines/data/responses/forms/node_response/node_response.dart';
import 'package:datalines/data/responses/responses.dart';
import 'package:datalines/presentation/resources/constants_manager.dart';
import 'package:dio/dio.dart'  ;

part  'api_client_impl.dart';

abstract class ApiClient {
  factory ApiClient(Dio dio) = ApiClientImpl;


  Future<AuthenticationResponse> login(
      String username, String password);

  Future<ForgetPasswordResponse> forgetPassword(
  String username);

  Future<AuthenticationResponse> register(
  String username,
   String password,
 String phone,
   String countryCode,
     String profilePicture,
  );




  Future<AssignedFormsResponse> getAssignedForms();


  Future<NodeBaseResponse> getNodes();


  Future<SyncFormBaseResponse>  syncForm(FormSyncRequest formSyncRequest,{void Function(int, int)?  onSyncProgress});

}
