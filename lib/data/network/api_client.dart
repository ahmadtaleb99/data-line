import 'dart:developer';

import 'package:form_builder_test/data/responses/forms/forms_response.dart';
import 'package:form_builder_test/data/responses/responses.dart';
import 'package:form_builder_test/presentation/resources/constants_manager.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

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


  @GET('/store-details/{id}')
  Future<StoreDetailsResponse> getStoreDetails(@Path() int id);

}