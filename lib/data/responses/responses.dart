import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: 'data')
  UserResponse? userResponse;



  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);

  AuthenticationResponse(this.userResponse);
}

@JsonSerializable()
class UserResponse {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'numberOfNotifications')
  int? numberOfNotifications;

  @JsonKey(name: 'name')
  String? name;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserResponse(this.name);
}


@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgetPasswordResponse(this.support);

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'image')
  String? image;

  ServiceResponse(this.id, this.title, this.image);

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'image')
  String? image;

  BannerResponse(this.id, this.title, this.image);

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'image')
  String? image;

  StoreResponse(this.id, this.title, this.image);

  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: 'services')
  List<ServiceResponse>? services;

  @JsonKey(name: 'banners')
  List<BannerResponse>? banners;

  @JsonKey(name: 'stores')
  List<StoreResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'data')
  HomeDataResponse homeDataResponse;

  HomeResponse(this.homeDataResponse);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}





@JsonSerializable()
class StoreDetailsResponse extends BaseResponse {
  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'details')
  String? details;

  @JsonKey(name: 'services')
  String? service;

  @JsonKey(name: 'about')
  String? about;


  StoreDetailsResponse(
      this.image, this.id, this.title, this.details, this.service, this.about);

  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);
}
