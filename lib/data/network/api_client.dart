import 'dart:developer';

import 'package:datalines/data/requests/forms/form_sync_request.dart';
import 'package:datalines/data/responses/forms/forms_response.dart';
import 'package:datalines/data/responses/forms/node_response/node_response.dart';
import 'package:datalines/data/responses/responses.dart';
import 'package:datalines/presentation/resources/constants_manager.dart';
import 'package:dio/dio.dart'  ;
import 'package:retrofit/http.dart' ;

part 'api_client.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  
  @POST('/customer/login')
  Future<AuthenticationResponse> login(
      @Field('username') String username, @Field('password') String password);

  @POST('/customer/forget-password')
  Future<ForgetPasswordResponse> forgetPassword(
      @Field('username') String username);

  @POST('/customer/register')
  Future<AuthenticationResponse> register(
    @Field('username') String username,
    @Field('password') String password,
    @Field('phone') String phone,
    @Field('country_code') String countryCode,
    @Field('profile_picture') String profilePicture,
  );



  @GET('/home')
  Future<HomeResponse> getHomeData();

  @GET('/get-forms')
  Future<AssignedFormsResponse> getAssignedForms();


  @GET('/get-nodes')
  Future<NodeBaseResponse> getNodes();

  @GET('/store-details/{id}')
  Future<StoreDetailsResponse> getStoreDetails(@Path() int id);

  @POST('/sync-form')
  @FormUrlEncoded()
  Future<SyncFormBaseResponse> syncForm(@Part() FormSyncRequest formSyncRequest);

}
