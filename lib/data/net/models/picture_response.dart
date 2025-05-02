import 'package:json_annotation/json_annotation.dart';

part 'picture_response.g.dart';

@JsonSerializable()
class PictureResponse {
  final String profilePictureUrl;

  factory PictureResponse.fromJson(Map<String, dynamic> json) =>
      _$PictureResponseFromJson(json);

  PictureResponse(this.profilePictureUrl);

  Map<String, dynamic> toJson() => _$PictureResponseToJson(this);
}
