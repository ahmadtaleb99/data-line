

part of 'api_client.dart';

class ApiClientImpl implements ApiClient {
  ApiClientImpl(this._dio, {this.baseUrl = ApiConstants.baseUrl}) ;

  final Dio _dio;

  String baseUrl;

  @override
  Future<AuthenticationResponse> login(username, password) async {

    final _data = {'username': username, 'password': password};
    final _result = await _dio.post(baseUrl + ApiConstants.loginUrl,data: _data);
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(username) async {
    final _data = {'username': username};
    final _result = await _dio.post(baseUrl + ApiConstants.forgetPasswordUrl,data: _data);
    final value = ForgetPasswordResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthenticationResponse> register(
      username, password, phone, countryCode, profilePicture) async {
    final _data = {
      'username': username,
      'password': password,
      'phone': phone,
      'country_code': countryCode,
      'profile_picture': profilePicture
    };
    final _result = await _dio.post(baseUrl + ApiConstants.registerUrl,data: _data);
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }



  @override
  Future<AssignedFormsResponse> getAssignedForms() async {

    final _result = await _dio.get(baseUrl + ApiConstants.getFormsUrl);
    final value = AssignedFormsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NodeBaseResponse> getNodes() async {
    final _result = await _dio.get(baseUrl + ApiConstants.getNodesUrl);

    final value = NodeBaseResponse.fromJson(_result.data!);
    return value;
  }


  @override
  Future<SyncFormBaseResponse> syncForm(formSyncRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('formSyncRequest', jsonEncode(formSyncRequest)));
    final _result = await _dio.post('path');
    final value = SyncFormBaseResponse.fromJson(_result.data!);
    return value;
  }


}
