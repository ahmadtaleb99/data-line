part of 'api_client.dart';

class ApiClientImpl implements ApiClient {
  ApiClientImpl(this._dio);

  final Dio _dio;



  @override
  Future<AuthenticationResponse> login(username, password) async {
    final _data = {'username': username, 'password': password};
    final _result = await _dio.post(ApiConstants.loginUrl, data: _data);
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(username) async {
    final _data = {'username': username};
    final _result =
        await _dio.post(ApiConstants.forgetPasswordUrl, data: _data);
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
    final _result = await _dio.post(ApiConstants.registerUrl, data: _data);
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssignedFormsResponse> getAssignedForms() async {
    final _result = await _dio.get(ApiConstants.getFormsUrl);
    final value = AssignedFormsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NodeBaseResponse> getNodes() async {
    final _result = await _dio.get(ApiConstants.getNodesUrl);

    final value = NodeBaseResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SyncFormBaseResponse> syncForm(FormSyncRequest formSyncRequest,
      {void Function(int, int)?  onSyncProgress}) async {
    final headers = DioFactory.getDefaultHeaders;
    headers[CONTENT_TYPE] = MULTIPART_FORMDATA;
    var  map = await formSyncRequest.toMultiPartMapRequest();
    final cancelToken = CancelToken();
    final _data = FormData.fromMap(map  );

    final _result = await _dio.post(ApiConstants.syncFormUrl,cancelToken: cancelToken, data: _data,options: Options(
     headers: headers
    ),
      onSendProgress: (send,total){
        onSyncProgress?.call(send,total);
      }
    );
    final value = SyncFormBaseResponse.fromJson(_result.data!);
    return value;
  }
}

