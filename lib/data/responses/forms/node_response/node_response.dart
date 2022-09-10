import 'package:datalines/data/responses/responses.dart';
import 'package:json_annotation/json_annotation.dart';
part 'node_response.g.dart';

@JsonSerializable()
class   NodeBaseResponse extends BaseResponse{

  @JsonKey(name: 'data')
  final   List<NodeResponse>? data;

    NodeBaseResponse(this.data);

    factory NodeBaseResponse.fromJson(Map<String, dynamic> json) =>
        _$NodeBaseResponseFromJson(json);
    Map<String, dynamic> toJson() => _$NodeBaseResponseToJson(this);

}


@JsonSerializable()
class NodeResponse{

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;


  factory NodeResponse.fromJson(Map<String, dynamic> json) =>
      _$NodeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NodeResponseToJson(this);

  const NodeResponse({
    required this.id,
    required this.name,
  });
}