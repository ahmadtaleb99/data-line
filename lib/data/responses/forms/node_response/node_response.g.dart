// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeBaseResponse _$NodeBaseResponseFromJson(Map<String, dynamic> json) =>
    NodeBaseResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => NodeResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$NodeBaseResponseToJson(NodeBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

NodeResponse _$NodeResponseFromJson(Map<String, dynamic> json) => NodeResponse(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$NodeResponseToJson(NodeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
