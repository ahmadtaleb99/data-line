import 'package:datalines/data/network/api_client.dart';
import 'package:datalines/data/requests/requests.dart';
import 'package:datalines/data/responses/forms/node_response/node_response.dart';
import 'package:datalines/data/responses/responses.dart';
import 'package:datalines/data/responses/forms/forms_response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetails(int id);

  Future<AssignedFormsResponse> getAssignedForms();
  Future<NodeBaseResponse> getNodes();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiClient _apiClient;
  RemoteDataSourceImpl(this._apiClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) {
    return _apiClient.login(loginRequest.username, loginRequest.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest) {
    return _apiClient.forgetPassword(forgetPasswordRequest.username);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) {
    return _apiClient.register(
      registerRequest.username,
      registerRequest.password,
      registerRequest.phone,
      registerRequest.countryCode,
      registerRequest.profilePicture,
    );
  }


  @override
  Future<HomeResponse> getHomeData() {
    return _apiClient.getHomeData();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails(int id) async {
    return await _apiClient.getStoreDetails(id);
  }

  @override
  Future<AssignedFormsResponse> getAssignedForms() async{
    return await  _apiClient.getAssignedForms();
  }

  @override
  Future<NodeBaseResponse> getNodes() async{
    final nodeResponse =  await _apiClient.getNodes();
    return nodeResponse;


  }
}
