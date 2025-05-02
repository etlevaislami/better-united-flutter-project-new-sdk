import 'package:json_annotation/json_annotation.dart';

part 'EventCategoryResponse.g.dart';

@JsonSerializable()
class EventCategoryResponse {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "pictureUrl")
  String? pictureUrl;
  @JsonKey(name: "iconUrl")
  String? iconUrl;

  EventCategoryResponse(this.id, this.name, this.pictureUrl, this.iconUrl);

  factory EventCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$EventCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventCategoryResponseToJson(this);
}